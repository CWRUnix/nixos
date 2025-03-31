# Based on these packaging instructions for .rpm
# https://github.com/TUM-DSE/doctor-cluster-config/blob/482b144f1220827d6c842af44a60576a0fb24309/pkgs/ipmctl.nix#L20
{
  stdenv,
  lib,
}: let
  current_folder = builtins.toString ./.;
in
  stdenv.mkDerivation rec {
    pname = "qualys-cloud-agent";
    version = "7.1";
    src = fetchurl {
      url = "file://${current_folder}/FIX_ME.rpm";
      sha256 = lib.fakeSha256;
    };
    #buildInputs = [libndctl systemd];
    #unpackPhase = ''
    #  rpmextract $src
    #  tar -xf ipmctl-${version}.tar.gz
    #  cd ipmctl-${version}
    #'';
    #NIX_CFLAGS_COMPILE = "-Wno-error";
    #nativeBuildInputs = [cmake python3 pkg-config asciidoctor asciidoc rpmextract];
    #cmakeFlags = [
    #  "-DBUILDNUM=1"
    #  "-DLINUX_PRODUCT_NAME=ipmctl"
    #  "-DRELEASE=ON"
    #];

    #meta = with lib; {
    #  description = "Utility for configuring and managing Intel Optane Persistent Memory modules";
    #  homepage = "https://github.com/intel/ipmctl";
    #  license = licenses.mit;
    #  maintainers = with maintainers; [mic92];
    #  platforms = platforms.unix;
    #};
  }
