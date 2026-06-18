{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "gpgcat";
        email = "gpgcat@proton.me";
      };
      init.defaultBranch = "main";
      user.signingKey = "25380268D6110BA6";
      commit.gpgSign = true;
      tag.gpgSign = true;
    };
  };
}
