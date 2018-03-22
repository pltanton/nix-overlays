self: super: 

{
  openvpn = super.lib.overrideDerivation super.openvpn (drv: {
    configureFlags = drv.configureFlags ++ ["--enable-pkcs11"];
    patches = [ ./openvpn-bug538-workaround.patch ];
    buildInputs = drv.buildInputs ++ [ self.pkcs11helper ];
  });
}
