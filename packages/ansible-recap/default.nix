{ lib, pkgs, writeShellApplication, ... }:

writeShellApplication {
  name = "ansible-recap";
  text = (builtins.readFile ../../ansible-recap);
  runtimeInputs = with pkgs; [
    bash
    jq
    gum
    coreutils # tr
  ];

  meta  = with lib; {
    description = "ansible-recap";
    licence = licences.gpl;
    platforms = platforms.all;
    mainProgram = "ansible-recap";
  };
}
