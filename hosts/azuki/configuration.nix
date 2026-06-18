{ config, lib, pkgs, ... }:
{
  networking.hostName = "azuki";
  networking.networkmanager.enable = true;
}

