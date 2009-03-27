// reduce memory footprint
user_pref("config.trim_on_minimize", true);
user_pref("browser.cache.memory.enable", true);
user_pref("browser.cache.memory.capacity", 8192);
user_pref("browser.sessionhistory.max_entries", 5);
user_pref("browser.sessionhistory.max_total_viewers", 5);

// restore pre-v2.0 access key behavior
user_pref("ui.key.generalAccessKey", -1);
user_pref("ui.key.contentAccess", 4);

// prevent selecting the entire contents of the location bar when it is clicked
user_pref("browser.urlbar.clickSelectsAll", false);

// increase responsiveness during page-loading
user_pref("content.notify.ontimer", true);
user_pref("content.interrupt.parsing", true);
user_pref("content.switch.threshold", 1000000);

// display domain for HTTPS URLs
user_pref("browser.identity.ssl_domain_display", 1);

// disable persistent zoom level
user_pref("browser.zoom.siteSpecific", false);

// enable print and scale options for print preview
user_pref("print.whileInPrintPreview", true);
