{ config, lib, pkgs, modulesPath, ... }:
{
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = ["amdgpu"];

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm    -    -    -    -    ${pkgs.rocmPackages.clr}"
  ];

  environment.systemPackages = with pkgs; [
    clinfo
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];
  };
}
