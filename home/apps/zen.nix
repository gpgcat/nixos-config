{ pkgs, ... }:
{
  programs.zen-browser = {
    enable = true;
    profiles.default = {
      settings = {
        "browser.tabs.warnOnClose" = false;
        "browser.urlbar.decodeURLsOnCopy" = true;

        # fix sandboxing
        "security.sandbox.content.read_path_whitelist" = "/nix/store";
      };

      search = {
        force = true;
        default = "ddg";
        engines = {
          nix-packages = {
            urls = [
              {
                template = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}";
              }
            ];

            name = "Nix Packages";
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };

          nixos-options = {
            urls = [
              {
                template = "https://search.nixos.org/options?channel=unstable&query={searchTerms}";
              }
            ];

            name = "NixOS Options";
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@no" ];
          };

          home-manager-options = {
            urls = [
              {
                template = "https://home-manager-options.extranix.com/?release=master";
                type = "searchform";
              }
              {
                template = "https://home-manager-options.extranix.com/?release=master&query={searchTerms}";
              }
            ];

            name = "Home Manager Options";
            icon = "https://home-manager-options.extranix.com/images/favicon.png";
            definedAliases = [
              "@homemanager"
              "@hm"
            ];
          };

          nixos-wiki = {
            urls = [ { template = "https://wiki.nixos.org/index.php?search={searchTerms}"; } ];

            name = "NixOS Wiki";
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@nw" ];
          };

          wiktionary-en = {
            urls = [
              {
                template = "https://en.wiktionary.org/wiki/Special:Search";
                type = "searchform";
              }
              {
                template = "https://en.wiktionary.org/w/index.php?title=Special:Search&search={searchTerms}";
              }
              {
                template = "https://en.wiktionary.org/w/api.php?action=opensearch&search={searchTerms}&namespace=0";
                type = "application/x-suggestions+json";
              }
              {
                template = "https://en.wiktionary.org/w/api.php?action=opensearch&format=xml&search={searchTerms}&namespace=0";
                type = "application/x-suggestions+xml";
              }
            ];

            name = "Wiktionary (en)";
            icon = "https://en.wiktionary.org/favicon.ico";
            definedAliases = [
              "@wiktionary"
              "@wt"
            ];
          };

          bing.metaData.hidden = true;
          perplexity.metaData.hidden = true;
        };
      };

      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
	bitwarden
	sponsorblock
	df-youtube
      ];
    };
  };
}
