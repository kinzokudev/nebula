{
  pkgs,
  config,
  ...
}: {
  home = {
    packages = with pkgs; [
      git
      lazygit
    ];
    shellAliases = {
      ga = "git add .";
      gc = "git commit -m";
      gp = "git push -u origin";
      lg = "lazygit";
    };
    file = {
      ".gitconfig".text = ''
        [user]
          name = kinzokudev
          email = kin@kinzoku.dev
          signingKey = ${config.home.homeDirectory}/.ssh/id_ed25519.pub
        [gpg]
          format = ssh
        [format]
          signOff = true
        [core]
          autocrlf = input
          editor = nvim
          excludesfile = ${config.home.homeDirectory}/.gitignore_global
        [commit]
          gpgSign = true
        [merge]
          ff = only
        [pull]
          rebase = true
        [status]
          submoduleSummary = false
        [tag]
          gpgSign = true
          forceSignAnnotated = true
        [init]
          defaultBranch = main
        [filter "lfs"]
          smudge = git-lfs smudge -- %f
          process = git-lfs filter-process
          required = true
          clean = git-lfs clean -- %f
        [url "ssh://git@github.com/"]
          pushInsteadOf = https://github.com/
        [push]
          autoSetupRemote = true
        [safe]
          directory = *
      '';
      ".gitignore_global".text = ''
        *~
        .DS_Store
        Thumbs.db
        unittest.xml
      '';
    };
  };
  xdg.configFile = {
    "lazygit/config.yml".text = ''
      gui:
        nerdFontsVersion: "3"
      git:
        commit:
          signOff: true
    '';
  };
}
