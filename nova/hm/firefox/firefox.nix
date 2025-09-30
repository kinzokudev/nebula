{
  pkgs,
  inputs,
  ...
}:
let
  extra-addons =
    let
      buildFirefoxXpiAddon =
        {
          src,
          pname,
          version,
          addonId,
        }:
        pkgs.stdenv.mkDerivation {
          name = "${pname}-${version}";

          inherit src;

          preferLocalBuild = true;
          allowSubstitutes = true;

          buildCommand = ''
            dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
            mkdir -p "$dst"
            install -v -m644 "$src" "$dst/${addonId}.xpi"
          '';
        };

      remoteXpiAddon =
        {
          pname,
          version,
          addonId,
          url,
          sha256,
        }:
        buildFirefoxXpiAddon {
          inherit pname version addonId;
          src = pkgs.fetchurl { inherit url sha256; };
        };
    in
    {
      read-aloud = remoteXpiAddon {
        pname = "read-aloud";
        version = "1.67.1";
        addonId = "{ddc62400-f22d-4dd3-8b4a-05837de53c2e}";
        url = "https://addons.mozilla.org/firefox/downloads/file/4219454/read_aloud-1.67.1.xpi";
        sha256 = "sha256-YLkh100nbuIYy7q+Vd0RQ4RN5N0tBWuExkGnDQw06UA=";
      };
      catppuccin-frappe-lavender = remoteXpiAddon {
        pname = "catppuccin-frappe-lavender";
        version = "unknown";
        addonId = "{5ee380f7-abda-467c-ae9a-d30bf8f0d1d6}";
        url = "https://github.com/catppuccin/firefox/releases/download/old/catppuccin_frappe_lavender.xpi";
        sha256 = "sha256-QEqZEED2R8XA8G4p1fYxKSHE+tVLZTP91lfzLxNUsxM=";
      };
      cf-purge-plugin = remoteXpiAddon {
        pname = "Cloudflare Purge Plugin";
        version = "1.5.1";
        addonId = "{0a40b0aa-001b-41c9-a3d7-7f4c4fe77025}";
        url = "https://addons.mozilla.org/firefox/downloads/file/1199228/cf_purge_plugin-1.5.1.xpi";
        sha256 = "sha256-duYhpU5YuVDYNHYTdvI2Do58ZJx5UrmjRjxARUOFNq8=";
      };
      youtube-for-tv = remoteXpiAddon {
        pname = "Youtube for TV";
        version = "0.0.3";
        addonId = "{d2bcedce-889b-4d53-8ce9-493d8f78612a}";
        url = "https://addons.mozilla.org/firefox/downloads/file/3420768/youtube_for_tv-0.0.3.xpi";
        sha256 = "sha256-Xfa7cB4D0Iyfex5y9/jRR93gUkziaIyjqMT0LIOhT6o=";
      };
      netflux = remoteXpiAddon {
        pname = "Netflux - 1080p, 5.1, & more for Netflix!";
        version = "1.0.11";
        addonId = "{b6d82d4f-9fc6-47f1-9191-bbabf829977c}";
        url = "https://addons.mozilla.org/firefox/downloads/file/4382056/netflux-1.0.11.xpi";
        sha256 = "sha256-R/Fz1nBljHLZValUnTRY3yNKM2HUvfx2+ph9QIppn2g=";
      };
      amazon-container = remoteXpiAddon {
        pname = "Amazon Container";
        version = "2.0.0";
        addonId = "@contain-amzn";
        url = "https://addons.mozilla.org/firefox/downloads/file/3455930/contain_amazon-2.0.0.xpi";
        sha256 = "sha256-DmHAhYb1GFKCSWL5yi9Nj8nkKG8+KkQRGu3pZEI0scA=";
      };
      regex-search = remoteXpiAddon {
        pname = "Regex Search";
        version = "1.0.17";
        addonId = "{cb08faed-9460-474a-ba0b-d98b13b5e001}";
        url = "https://addons.mozilla.org/firefox/downloads/file/3353167/regexsearch-1.0.17.xpi";
        sha256 = "sha256-HI9KQjESxLcxzamibguQkQwmWUFn/HY1rRtQYQ1hGEA=";
      };
    };
in
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    policies = {
      DefaultDownloadDirectory = "\${home}/Downloads";
    };
    profiles = {
      "freeform" = {
        isDefault = true;
        search = {
          force = true;
          default = "Brave";
          privateDefault = "Brave";
          engines = {
            "Nix Packages" = {
              urls = [
                {
                  # https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={searchTerms}
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "channel";
                      value = "unstable";
                    }
                    {
                      name = "from";
                      value = "0";
                    }
                    {
                      name = "size";
                      value = "50";
                    }
                    {
                      name = "sort";
                      value = "relevance";
                    }
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "!np" ];
            };
            "NixOS Options" = {
              urls = [
                {
                  # https://search.nixos.org/options?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={searchTerms}
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "channel";
                      value = "unstable";
                    }
                    {
                      name = "from";
                      value = "0";
                    }
                    {
                      name = "size";
                      value = "50";
                    }
                    {
                      name = "sort";
                      value = "relevance";
                    }
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "!no" ];
            };
            "NixOS Wiki" = {
              urls = [
                {
                  template = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
                }
              ];
              # iconUpdateURL = "https://nixos.wiki/favicon.png";
              iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "!nw" ];
            };
            "ProtonDB" = {
              urls = [ { template = "https://www.protondb.com/search?q={searchTerms}"; } ];
              iconUpdateURL = "https://icons.iconarchive.com/icons/simpleicons-team/simple/256/protondb-icon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "!pdb" ];
            };
            "Qwant" = {
              urls = [ { template = "https://www.qwant.com/?q={searchTerms}"; } ];
              iconUpdateURL = "https://upload.wikimedia.org/wikipedia/commons/2/2b/Qwant-Icone-2022.svg";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = [ "!q" ];
            };
            "Qwant Images" = {
              urls = [ { template = "https://www.qwant.com/?t=images&q={searchTerms}"; } ];
              iconUpdateURL = "https://upload.wikimedia.org/wikipedia/commons/2/2b/Qwant-Icone-2022.svg";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = [ "!i" ];
            };
            "Brave" = {
              urls = [ { template = "https://search.brave.com/search?q={searchTerms}"; } ];
              iconUpdateURL = "https://upload.wikimedia.org/wikipedia/commons/5/51/Brave_icon_lionface.png";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = [ "!b" ];
            };
            "Brave Images" = {
              urls = [
                {
                  # https://search.brave.com/images?q=abcdef
                  template = "https://search.brave.com/images?q={searchTerms}";
                }
              ];
              iconUpdateURL = "https://upload.wikimedia.org/wikipedia/commons/5/51/Brave_icon_lionface.png";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = [ "!bi" ];
            };
            "Flathub" = {
              urls = [ { template = "https://flathub.org/apps/search?q={searchTerms}"; } ];
              iconUpdateURL = "https://styles.redditmedia.com/t5_3k6jw/styles/communityIcon_b1hyv6wssjd91.png";
              updateInterval = 24 * 60 * 1000;
              definedAliases = [
                "!f"
                "!flathub"
                "!flatpak"
              ];
            };
            "Github Code" = {
              urls = [ { template = "https://github.com/search?q={searchTerms}&type=code"; } ];
              definedAliases = [
                "!code"
                "!ghc"
                "!gc"
              ];
              iconUpdateURL = "https://upload.wikimedia.org/wikipedia/commons/9/91/Octicons-mark-github.svg";
              updateInterval = 24 * 60 * 1000;
            };
            "Github Repos" = {
              urls = [ { template = "https://github.com/search?q={searchTerms}&type=repositories"; } ];
              definedAliases = [
                "!gh"
                "!repo"
              ];
              iconUpdateURL = "https://upload.wikimedia.org/wikipedia/commons/9/91/Octicons-mark-github.svg";
              updateInterval = 24 * 60 * 1000;
            };
            "Youtube" = {
              urls = [ { template = "https://www.youtube.com/results?search_query={searchTerms}"; } ];
              definedAliasses = [
                "!yt"
                "!y"
              ];
              iconUpdateURL = "https://imgs.search.brave.com/0s_rkLjPXG0u6MFQl24I-Debkq4Mp8JmX04Any5mq6c/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9jZG4t/aWNvbnMtcG5nLmZy/ZWVwaWsuY29tLzI1/Ni8xMzg0LzEzODQw/NjAucG5n";
              updateInterval = 24 * 60 * 1000;
            };
            "Bing".metaData.hidden = true;
            "Google".metaData = {
              hidden = true;
              alias = "!g"; # builtin engines only support specifying one additional alias
            };
            "DuckDuckGo".metaData = {
              hidden = true;
              alias = "!ddg";
            };
          };
          order = [
            "Brave"
            "Brave Images"
            "Nix Packages"
            "NixOS Wiki"
            "Youtube"
            "Flathub"
          ];
        };
        extensions =
          with inputs.nur.legacyPackages.${pkgs.system}.repos.rycee.firefox-addons;
          with extra-addons;
          [
            sidebery
            (onepassword-password-manager.overrideAttrs { meta.license.free = true; })
            ublock-origin
            sponsorblock
            darkreader
            dearrow
            enhanced-h264ify
            firefox-color
            fx_cast
            iina-open-in-mpv
            protondb-for-steam
            terms-of-service-didnt-read
            vimium-c
            gesturefy
            no-pdf-download
            istilldontcareaboutcookies
            violentmonkey
            stylus
            torrent-control
            to-deepl
            blocktube
            decentraleyes
            clearurls
            user-agent-string-switcher
            wayback-machine
            youtube-shorts-block
            return-youtube-dislikes
            (youtube-recommended-videos.overrideAttrs { meta.license.free = true; })
            (flagfox.overrideAttrs { meta.license.free = true; })
            (enhancer-for-youtube.overrideAttrs { meta.license.tree = true; })
            read-aloud
            open-tabs-next-to-current
            cf-purge-plugin
            btroblox
            (w2g.overrideAttrs { meta.license.free = true; })
            youtube-for-tv
            amazon-container
            facebook-container
            google-container
            multi-account-containers
            netflux
            libredirect
            regex-search
            catppuccin-frappe-lavender # theme
          ];
        userChrome = ''
          ${builtins.readFile ./userChrome.css}
        '';
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "browser.aboutConfig.showWarning" = false;
          "browser.startup.page" = 0;
          "browser.preferences.experimental" = true;
          "browser.startup.homepage" = "about:home";
          "browser.newtabpage.enabled" = true;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.activity-stream.default.sites" = "";
          "extensions.getAddons.showPane" = false;
          "extensions.htmlaboutaddons.recommendations.enabled" = false;
          "browser.discovery.enabled" = false;
          "extensions.unifiedExtensions.enabled" = false;
          "datareporting.policy.dataSubmissionEnabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.server" = "data:,";
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.updatePing.enabled" = false;
          "toolkit.telemetry.bhrPing.enabled" = false;
          "toolkit.telemetry.firstShutdownPing.enabled" = false;
          "toolkit.telemetry.coverage.opt-out" = true;
          "toolkit.coverage.endpoint.base" = "";
          "browser.ping-centre.telemetry" = false;
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.newtabpage.activity-stream.telemetry" = false;
          "app.shield.optoutstudies.enabled" = false;
          "app.normandy.enabled" = false;
          "app.normandy.api_url" = "";
          "breakpad.reportURL" = "";
          "browser.tabs.crashReporting.sendReport" = false;
          "browser.crashReports.unsubmittedCheck.enabled" = false;
          "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
          "captivedetect.canonicalURL" = "";
          "network.captive-portal-service.enabled" = false;
          "network.connectivity-service.enabled" = false;
          "browser.safebrowsing.malware.enabled" = false;
          "browser.safebrowsing.phishing.enabled" = false;
          "browser.safebrowsing.downloads.enabled" = false;
          "browser.safebrowsing.downloads.remote.enabled" = false;
          "browser.safebrowsing.downloads.remote.url" = "";
          "browser.safebrowsing.downloads.remote.block_potentially_unwanted" = false;
          "browser.safebrowsing.downloads.remote.block_uncommon" = false;
          "browser.safebrowsing.allowOverride" = false;
          "privacy.resistFingerprinting.block_mozAddonManager" = true;
          "signon.rememberSignons" = false;
          "gfx.webrender.all" = true;
          "media.ffmpeg.vaapi.enabled" = true;
          "extensions.pocket.enabled" = false;
          "browser.newtabpage.activity-stream.topSitesRows" = 2;
          "general.smoothScroll" = true;
          "general.autoScroll" = true;
          "sidebar.revamp" = true;
          "sidebar.verticalTabs" = true;
          "sidebar.main.tools" = "aichat,syncedtabs,history,bookmarks";
          "sidebar.visibility" = "always-show";
          "sidebar.position_start" = true;
          "devtools.toolbox.sidebar.width" = 480;
          "browser.newtabpage.activity-stream.showRecentSaves" = false;
          "browser.taskbar.lists.enabled" = false;
          "browser.taskbar.lists.frequent.enabled" = false;
          "browser.taskbar.lists.tasks.enabled" = false;
          "browser.newtabpage.activity-stream.enabled" = false;
          "browser.newtabpage.pinned" = [
            {
              label = "Youtube";
              url = "https://www.youtube.com/feed/subscriptions";
            }
            {
              label = "Discord";
              url = "https://discord.com/app";
            }
            {
              label = "Proton Calendar";
              url = "https://account.proton.me/calendar";
            }
            {
              label = "Github";
              url = "https://github.com";
            }
            {
              label = "DeepL";
              url = "https://deepl.com";
            }
            {
              label = "Router";
              url = "https://192.168.40.1";
            }
            {
              label = "ProtonDB";
              url = "https://www.protondb.com/";
            }
            {
              label = "Pocket";
              url = "https://getpocket.com/saves";
            }
          ];
        };
        bookmarks = [
          {
            name = "Hosted";
            bookmarks = [
              {
                name = "Twingate";
                url = "https://kinzoku.twingate.com";
              }
              {
                name = "Gatus";
                url = "https://status.kinzoku.dev";
              }
              {
                name = "Grafana";
                url = "https://grafana.kinzoku.dev";
              }
              {
                name = "IT Tools";
                url = "https://it-tools.kinzoku.dev";
              }
              {
                name = "ConvertX";
                url = "https://convert.kinzoku.dev";
              }
            ];
          }
          {
            name = "Nix";
            bookmarks = [
              {
                name = "NixOS Wiki";
                url = "https://nixos.wiki/wiki/";
              }
              {
                name = "nixiv";
                url = "https://wiki.nikiv.dev/package-managers/nix/";
              }
              {
                name = "Zero to Nix";
                url = "https://zero-to-nix.com/";
              }
              {
                name = "NixOS & Flakes Book";
                url = "https://nixos-and-flakes.thiscute.world/";
              }
              {
                name = "MyNixOS";
                url = "https://mynixos.com/";
              }
              {
                name = "OuterHeaven";
                url = "https://github.com/liquidovski/OuterHeaven";
              }
              {
                name = "HM Options";
                url = "https://nix-community.github.io/home-manager/options.xhtml";
              }
              {
                name = "nvf docs";
                url = "https://notashelf.github.io/nvf/options.html";
              }
              {
                name = "nixpkgs";
                url = "https://github.com/NixOS/nixpkgs/";
              }
              {
                name = "PR Tracker";
                url = "https://nixpk.gs/pr-tracker.html";
              }
              {
                name = "nixcord options";
                url = "https://github.com/KaylorBen/nixcord/blob/main/docs/plugins.md";
              }
              {
                name = "mdadm";
                url = "https://gist.github.com/seanjensengrey/b69ffddbc668e127b1946d4c147e0bcb";
              }
            ];
          }
          {
            name = "Utils";
            bookmarks = [
              {
                name = "Steam Sale Dates";
                url = "https://steamdb.info/sales/history/";
              }
              {
                name = "De-Googled App DB";
                url = "https://plexus.techlore.tech/";
              }
              {
                name = "CyberChef";
                url = "https://gchq.github.io/CyberChef/";
              }
              {
                name = "YT Thumnail";
                url = "https://downdetector.com/";
              }
              {
                name = "Video Embedder";
                url = "https://stolen.shoes/";
              }
              {
                name = "Carrd";
                url = "https://carrd.co/build";
              }
              {
                name = "Flourish";
                url = "https://flourish.studio/";
              }
            ];
          }
          {
            name = "Tutorials";
            bookmarks = [
              {
                name = "Davinci Resolve Linux Cheat Sheet";
                url = "https://alecaddd.com/davinci-resolve-ffmpeg-cheatsheet-for-linux/";
              }
              {
                name = "Python w3s";
                url = "https://www.w3schools.com/python/default.asp";
              }
              {
                name = "Godot Docs";
                url = "https://docs.godotengine.org/en/stable/about/introduction.html";
              }
              {
                name = "Git Book";
                url = "https://git-scm.com/book/en/v2";
              }
              {
                name = "Wayland Root";
                url = "https://github.com/swaywm/sway/wiki#wayland-wont-let-me-run-apps-as-root";
              }
              {
                name = "Nginx-Proxy Tutor";
                url = "https://medium.com/@life-is-short-so-enjoy-it/homelab-nginx-proxy-manager-setup-ssl-certificate-with-domain-name-in-cloudflare-dns-732af64ddc0b";
              }
              {
                name = "EasyEffects Pipewire Screensharing";
                url = "https://gist.github.com/amsyarzero/57ff8e566af48265950aead5ff900ce5";
              }
            ];
          }
          {
            name = "Anime";
            bookmarks = [
              {
                name = "Filler List";
                url = "https://www.animefillerlist.com/";
              }
              {
                name = "MAL";
                url = "https://myanimelist.net/";
              }
            ];
          }
        ];
      };
    };
  };
}
