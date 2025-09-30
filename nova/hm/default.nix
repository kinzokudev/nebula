{ inputs, ... }:
{
  imports = [
    ./home.nix
    ./discord.nix
    ./kitty.nix
    ./tmux.nix
    ./obs
    ./niri.nix
  ];
}
