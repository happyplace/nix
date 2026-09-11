{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    texliveFull # the FULL latex

    # Vulkan Development
    vulkan-headers
    vulkan-loader
    vulkan-validation-layers
    vulkan-tools        # vulkaninfo
    shaderc             # GLSL to SPIRV compiler - glslc
    renderdoc           # Graphics debugger
    tracy               # profiler
    vulkan-tools-lunarg # vkconfig
    glslang

    # Development
    sdl3
    gdb
    gcc
    clang
    cmakeWithGui
    gnumake
    assimp
    rustup
    zig
    vscode
    qtcreator
    clang-tools

    # Packages that are usually flatpaks
    blender
    calibre
    darktable
    github-desktop
    handbrake
    kdePackages.kdenlive
    krita
    obs-studio
    texstudio
    localsend
  ];
}
