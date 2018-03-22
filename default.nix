self: super:

with super.lib;

(foldl' (flip extends) (_: super) [

  (import ./pkgs/all-packages.nix)
  (import ./overrides/all-overrides.nix)

]) self

