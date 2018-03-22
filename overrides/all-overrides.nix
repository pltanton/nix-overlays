self: super:

with super.lib;

(foldl' (flip extends) (_: super) [

  (import ./openvpn.nix)

]) self

