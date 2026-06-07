{ ... }:

{
  # Laptop profile: extends desktop. Laptop-specific configuration
  # (fprintd, HiDPI font scaling, lid-close behaviour, etc.) is deferred
  # until PR3, when each candidate gets audited individually.
  imports = [ ../desktop ];
}
