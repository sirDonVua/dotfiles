{ config, pkgs, ... }:


{

  #open gl and vulkan
  hardware.opengl.extraPackages = with pkgs; [
  rocm-opencl-icd
  rocm-opencl-runtime
];

  hardware.opengl.driSupport = true;
  # For 32 bit applications
  hardware.opengl.driSupport32Bit = true;
  boot.initrd.kernelModules = [ "amdgpu" ];

}
