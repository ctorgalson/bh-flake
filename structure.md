# Structure Planning

## Per Machine Config

- device config (hardware / boot / filesystems)
- role config (e.g. desktop / server)
- overrides

This should permit sufficient configurability:

- each host has a device config named `hardware-configuration.nix`,
- each host has a role that's used to choose a path for its basic setup,
- each host may override configuration properties like `foo.bar.baz = 'lorem'`,
- as far as possible, each host's configuration is done with home-manager,

This is all orchestrated by a single flake. The file structure

bh-flake/
├─flake.nix
├─hosts/
│ ├─default.nix
│ ├─framework13/ 
│ │ ├─default.nix
│ │ └─hardware-configuration.nix
│ ├─executive14/ 
│ │ ├─default.nix
│ │ └─hardware-configuration.nix
│ └─ser6/ 
│   ├─default.nix
│   └─hardware-configuration.nix
├─modules/
│ ├─default.nix
│ ├─home-manager/
│ │ ├─default.nix
│ │ ├─pkgs/ 
│ │ │ └─default.nix
│ │ ├─programs/ 
│ │ │ └─default.nix
│ │ └─services/ 
│ │   └─default.nix
│ └─nixos/ 
│   ├─default.nix
│   └─services/ 
│     └─default.nix
└─roles/
   ├─common/ 
   │ └─default.nix
   ├─desktop/ 
   │ └─default.nix
   └─server/ 
     └─default.nix
