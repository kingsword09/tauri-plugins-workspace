# THIS FILE IS AUTO-GENERATED. DO NOT MODIFY!!

# Copyright 2020-2023 Tauri Programme within The Commons Conservancy
# SPDX-License-Identifier: Apache-2.0
# SPDX-License-Identifier: MIT

-keep class tech.kingsword.tauri.example.app.* {
  native <methods>;
}

-keep class tech.kingsword.tauri.example.app.WryActivity {
  public <init>(...);

  void setWebView(tech.kingsword.tauri.example.app.RustWebView);
  java.lang.Class getAppClass(...);
  java.lang.String getVersion();
}

-keep class tech.kingsword.tauri.example.app.Ipc {
  public <init>(...);

  @android.webkit.JavascriptInterface public <methods>;
}

-keep class tech.kingsword.tauri.example.app.RustWebView {
  public <init>(...);

  void loadUrlMainThread(...);
  void loadHTMLMainThread(...);
  void evalScript(...);
}

-keep class tech.kingsword.tauri.example.app.RustWebChromeClient,tech.kingsword.tauri.example.app.RustWebViewClient {
  public <init>(...);
}
