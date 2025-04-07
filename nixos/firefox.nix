{ config, lib, pkgs, inputs, ... }:

{

  programs.firefox = {

    enable = true;
    policies = {
      AutoFillAddressEnabled = false;
      OfferToSaveLoginsDefault = false;
      DisableFirefoxAccounts = true;
      DisableFirefoxStudies = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      DisablePocket = true;
    };
    profiles.derp = {
      id = 0;
      name = "Derp";
      isDefault = true;
      settings = {

        # Privacy settings
        "privacy.donottrackheader.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "privacy.partition.network_state.ocsp_cache" = true;

        # Disable all sorts of telemetry
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.ping-centre.telemetry" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.updatePing.enabled" = false;

        # As well as Firefox 'experiments'
        "experiments.activeExperiment" = false;
        "experiments.enabled" = false;
        "experiments.supported" = false;
        "network.allow-experiments" = false;


      };
      extensions.packages =
        let
          version = "4.0.7.0";
          # Workaround until it gets fixed in upstream
          bypass-paywalls-clean = pkgs.callPackage
            (with inputs.firefox-addons.lib."x86_64-linux"; buildFirefoxXpiAddon)
            {
              pname = "bypass-paywalls-clean";
              version = version;
              addonId = "magnolia@12.34";
              url =
                "https://gitflic.ru/project/magnolia1234/bpc_uploads/blob/raw?file=bypass_paywalls_clean-${version}.xpi";
              sha256 = "7de4ed110771380dac22eecf07806c9638f0a3237cc8867da57ad0fc07a9c8c3";
              meta = with lib; {
                homepage = "https://twitter.com/Magnolia1234B";
                description = "Bypass Paywalls of (custom) news sites";
                license = licenses.mit;
                platforms = platforms.all;
              };
            };
        in
        with inputs.firefox-addons.packages."x86_64-linux"; [
          ublock-origin
          vimium
          bypass-paywalls-clean
          keepassxc-browser
          single-file
          violentmonkey
          old-reddit-redirect
	  istilldontcareaboutcookies
        ];
    };
  };
}
