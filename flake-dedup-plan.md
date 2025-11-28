# Flake.nix Deduplication Refactoring Plan

## Overview

**Goal:** Eliminate ~200+ lines of duplication in `flake.nix` while keeping complexity manageable.

**Current Issues:**
- Massive duplication in colmena configuration (~200 lines)
- bh deployment user configuration duplicated in 3 locations
- Maintenance burden when making changes to deployment setup

## Current Duplication Analysis

### 1. Colmena Section Duplication (lines 92-193)

Each of the 4 hosts has nearly identical configuration blocks:

**Duplicated Elements (repeated 3x for desktop hosts):**
```nix
deployment = {
  targetHost = "<hostname>";
  targetUser = "bh";
};

_module.args = {
  inherit system;
  host = { hostname = "<name>"; role = "desktop"; username = "ctorgalson"; };
};

imports = [
  sops-nix.nixosModules.sops
  stylix.nixosModules.stylix
  home-manager.nixosModules.default
  {
    home-manager.extraSpecialArgs = {
      inherit inputs stable-pkgs system;
      host = { hostname = "<name>"; role = "desktop"; username = "ctorgalson"; };
    };
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
  }
  ./roles/desktop
  ./hosts/<hostname>
];

nixpkgs.hostPlatform = system;
```

**Total:** ~75 lines × 3 hosts = 225 lines that could be reduced to ~30 lines

### 2. bh User & Sudo Configuration (3 locations)

**Location 1:** `roles/desktop/nixos/users/default.nix` (lines 17-23)
```nix
config.users.users.bh = {
  description = "Colmena deployment user";
  isNormalUser = true;
  extraGroups = [ "wheel" ];
};
```

**Location 2:** `roles/desktop/nixos/security/default.nix` (lines 6-26)
```nix
security.sudo.extraRules = [
  {
    users = [ "bh" ];
    commands = [
      { command = "/nix/store/*/bin/switch-to-configuration"; options = [ "NOPASSWD" ]; }
      { command = "/nix/store/*/activate"; options = [ "NOPASSWD" ]; }
      { command = "/run/current-system/sw/bin/nix-env"; options = [ "NOPASSWD" ]; }
    ];
  }
];
```

**Location 3:** `hosts/pi0/configuration.nix` (lines 77-103)
- Exact duplicate of both user and sudo configuration

**Impact:** Changes to deployment user must be made in 3 places

## Proposed Refactoring

### Step 1: Create Shared Deployment User Module

**New File:** `modules/deployment-user.nix`

**Purpose:** Single source of truth for bh user and sudo configuration

**Contents:**
```nix
{ ... }:

{
  # Colmena deployment user (authentication via Tailscale SSH)
  users.users.bh = {
    description = "Colmena deployment user";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  # Limited passwordless sudo for Colmena deployment user
  security.sudo.extraRules = [
    {
      users = [ "bh" ];
      commands = [
        {
          command = "/nix/store/*/bin/switch-to-configuration";
          options = [ "NOPASSWD" ];
        }
        {
          command = "/nix/store/*/activate";
          options = [ "NOPASSWD" ];
        }
        {
          command = "/run/current-system/sw/bin/nix-env";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}
```

### Step 2: Update Desktop Role

**File:** `roles/desktop/default.nix`
- Add import: `../../modules/deployment-user.nix`

**File:** `roles/desktop/nixos/users/default.nix`
- Remove bh user definition (lines 17-23)
- Keep ctorgalson user definition

**File:** `roles/desktop/nixos/security/default.nix`
- Remove sudo extraRules (lines 6-26)
- Keep rtkit.enable

### Step 3: Update pi0 Configuration

**File:** `hosts/pi0/configuration.nix`
- Remove bh user definition (lines 78-82)
- Remove sudo extraRules (lines 85-103)
- Add import: `../../modules/deployment-user.nix`

**Rationale:** pi0 is a minimal appliance - no regular user needed, only deployment access

### Step 4: Create mkColmenaHost Helper Function

**File:** `flake.nix` (add to `let` block, ~line 39)

```nix
mkColmenaHost = hostname: role: username: hostSystem: {
  deployment = {
    targetHost = hostname;
    targetUser = "bh";
  };

  _module.args = {
    # Use x86_64 system for building if target is aarch64
    system = if hostSystem == "aarch64-linux" then "x86_64-linux" else hostSystem;
    host = { inherit hostname role username; };
  };

  imports = [
    sops-nix.nixosModules.sops
    stylix.nixosModules.stylix
    home-manager.nixosModules.default
    {
      home-manager.extraSpecialArgs = {
        inherit inputs stable-pkgs;
        system = hostSystem;
        host = { inherit hostname role username; };
      };
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
    }
    ./roles/${role}
    ./hosts/${hostname}
  ];

  nixpkgs.hostPlatform = hostSystem;
};
```

### Step 5: Simplify Colmena Configuration

**File:** `flake.nix` (colmena section)

**Before:** ~100 lines of repetitive configuration

**After:**
```nix
colmena = {
  meta = {
    nixpkgs = import nixpkgs { inherit system; };
    specialArgs = { inherit inputs stable-pkgs; };
  };

  # Desktop hosts (x86_64-linux)
  framework13 = mkColmenaHost "framework13" "desktop" "ctorgalson" system;
  ser6 = mkColmenaHost "ser6" "desktop" "ctorgalson" system;
  executive14 = mkColmenaHost "executive14" "desktop" "ctorgalson" system;

  # ARM appliance (aarch64-linux)
  pi0 = (mkColmenaHost "pi0" "appliance" null "aarch64-linux") // {
    deployment.buildOnTarget = false;
  };
};
```

**Note:** May need to create minimal `roles/appliance` or adjust function to handle null role

## Expected Results

### Quantitative
- **Lines removed from flake.nix:** ~200 lines
- **New files created:** 1 module (~30 lines)
- **New functions created:** 1 helper (~30 lines)
- **Net reduction:** ~140 lines across project

### Qualitative
- **Single source of truth** for deployment user configuration
- **Consistent** deployment configuration across all hosts
- **Maintainable** - changes only needed in one place
- **Readable** - colmena section becomes self-documenting
- **Extensible** - easy to add new hosts

## Complexity Trade-off

### Added Complexity
- 1 new module file (`modules/deployment-user.nix`)
- 1 helper function (`mkColmenaHost`)
- Total: ~60 lines of new code

### Removed Complexity
- ~230 lines of duplicated configuration
- 2 locations where bh user must be maintained
- 2 locations where sudo rules must be maintained

### Net Result
**Much simpler and more maintainable**

## Implementation Checklist

- [x] Create `modules/users.nix` (centralized admin + deployment users)
- [x] Update `roles/desktop/default.nix` to import module
- [x] Remove entire `roles/desktop/nixos/users/` directory
- [x] Remove sudo rules from `roles/desktop/nixos/security/default.nix`
- [x] Update `hosts/pi0/configuration.nix` to import module with SOPS password
- [x] Add `mkColmenaHost` function to `flake.nix`
- [x] Simplify colmena configuration in `flake.nix`
- [x] Test: `sudo nixos-rebuild switch --flake '.?submodules=1'` on local host
- [x] Test: `colmena apply` on remote host
- [x] Verify bh user exists on all hosts
- [x] Verify sudo works for deployment
- [x] Remove obsolete SSH authorized keys (now using Tailscale SSH)
- [ ] Extract home-manager configuration block into separate reusable function

## Rollback Plan

If issues occur:
1. Git revert the changes
2. Redeploy previous configuration
3. All hosts have known-good state from before refactoring

## Future Considerations

### Potential Further Improvements
1. Create similar helper for nixosConfigurations (though mkHost already exists)
2. Consider architecture-aware mkHost that handles both x86_64 and aarch64
3. Extract home-manager configuration block into separate reusable function
4. Consider if pi0 needs a "role" or if role can be optional in helper

### Not Recommended
- Don't try to unify nixosConfigurations and colmena too tightly - they serve different purposes
- Don't over-abstract - some duplication is acceptable if it improves clarity
