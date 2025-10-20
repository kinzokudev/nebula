{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.nixcord.homeModules.nixcord];
  options.custom = {
    discord = {
      enable = lib.mkEnableOption "Discord";
    };
  };
  config = lib.mkIf config.custom.discord.enable {
    xdg.desktopEntries = {
      "discord-canary" = lib.mkForce {
        name = "Discord Canary";
        type = "Application";
        icon = "discord-canary";
        terminal = false;
        exec = "DiscordCanary --enable-features=VaapiIgnoreDriverChecks,VaapiVideoEncoder,VaapiVideoDecoder,CanvasOopRasterization,UseMultiPlaneFormatForHardwareVideo,MiddleClickAutoscroll,UseOzonePlatform --ozone-platform=wayland";
      };
    };
    programs.nixcord = {
      enable = true;
      discord = {
        enable = true;
        vencord = {
          enable = false;
          package = pkgs.vencord;
        };
        openASAR.enable = false;
        package = pkgs.discord-canary;
      };
      vesktop = {
        enable = true;
        package = pkgs.vesktop.overrideAttrs {
          desktopItems = [
            (pkgs.makeDesktopItem {
              name = "vesktop";
              desktopName = "Discord";
              exec = "vesktop --enable-features=VaapiIgnoreDriverChecks,VaapiVideoEncoder,VaapiVideoDecoder,CanvasOopRasterization,UseMultiPlaneFormatForHardwareVideo,MiddleClickAutoscroll,UseOzonePlatform --ozone-platform=wayland";
              icon = "discord";
              startupWMClass = "VencordDesktop";
              genericName = "Internet Messenger";
              keywords = [
                "discord"
                "vencord"
                "electron"
                "chat"
              ];
              categories = [
                "Network"
                "InstantMessaging"
                "Chat"
              ];
            })
          ];
        };
      };
      config = {
        themeLinks = [
          "https://raw.githubusercontent.com/ardishco-the-great/catpuccin-discord/main/themes/frappe.theme.css"
        ];
        frameless = false;
        plugins = {
          alwaysTrust.enable = true;
          anonymiseFileNames = {
            enable = true;
            anonymiseByDefault = true;
          };
          # betterFolders = {
          #   enable = true;
          #   showFolderIcon = "always";
          # };
          betterGifAltText.enable = true;
          betterGifPicker.enable = true;
          betterNotesBox.enable = true;
          betterRoleDot.enable = true;
          betterUploadButton.enable = true;
          blurNSFW.enable = true;
          # callTimer.enable = true;
          clearURLs.enable = true;
          crashHandler.enable = true;
          dearrow.enable = true;
          experiments.enable = true;
          fakeNitro.enable = true;
          favoriteEmojiFirst.enable = true;
          favoriteGifSearch.enable = true;
          fixSpotifyEmbeds.enable = true;
          fixYoutubeEmbeds.enable = true;
          forceOwnerCrown.enable = true;
          friendInvites.enable = true;
          friendsSince.enable = true;
          fullSearchContext.enable = true;
          fixCodeblockGap.enable = true;
          gameActivityToggle.enable = true;
          gifPaste.enable = true;
          imageZoom.enable = true;
          loadingQuotes.enable = true;
          memberCount.enable = true;
          messageClickActions.enable = true;
          messageLogger = {
            enable = true;
            deleteStyle = "text";
            logDeletes = true;
            logEdits = true;
            ignoreSelf = true;
          };
          messageTags.enable = true;
          moreCommands.enable = true;
          moreKaomoji.enable = true;
          mutualGroupDMs.enable = true;
          newGuildSettings.enable = true;
          noBlockedMessages = {
            enable = true;
            ignoreBlockedMessages = true;
          };
          noDevtoolsWarning.enable = true;
          noF1.enable = true;
          noReplyMention = {
            enable = true;
            userList = "";
            shouldPingListed = false;
          };
          noProfileThemes.enable = true;
          noUnblockToJump.enable = true;
          openInApp.enable = true;
          permissionFreeWill.enable = true;
          pictureInPicture.enable = true;
          pinDMs.enable = true;
          plainFolderIcon.enable = true;
          platformIndicators.enable = true;
          previewMessage.enable = true;
          quickMention.enable = true;
          quickReply.enable = true;
          reactErrorDecoder.enable = true;
          relationshipNotifier.enable = true;
          replaceGoogleSearch = {
            enable = true;
          };
          secretRingToneEnabler.enable = true;
          sendTimestamps.enable = true;
          showHiddenChannels.enable = true;
          showHiddenThings.enable = true;
          silentTyping.enable = true;
          sortFriendRequests.enable = true;
          spotifyControls.enable = true;
          spotifyCrack.enable = true;
          spotifyShareCommands.enable = true;
          translate.enable = true;
          typingIndicator.enable = true;
          typingTweaks.enable = true;
          unsuppressEmbeds.enable = true;
          userVoiceShow.enable = true;
          USRBG.enable = true;
          vencordToolbox.enable = true;
          viewIcons.enable = true;
          voiceChatDoubleClick.enable = true;
          voiceMessages.enable = true;
          volumeBooster = {
            enable = true;
            multiplier = 5;
          };
          webKeybinds.enable = true;
          webRichPresence.enable = true;
          whoReacted.enable = true;
          youtubeAdblock.enable = true;
          webScreenShareFixes.enable = true;
          noTypingAnimation.enable = true;
        };
      };
    };
  };
}
