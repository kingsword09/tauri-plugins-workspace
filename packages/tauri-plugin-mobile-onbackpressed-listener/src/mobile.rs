use serde::de::DeserializeOwned;
use tauri::{
  plugin::{PluginApi, PluginHandle},
  AppHandle, Runtime,
};

#[cfg(target_os = "ios")]
tauri::ios_plugin_binding!(init_plugin_mobile_onbackpressed_listener);

// initializes the Kotlin or Swift plugin classes
pub fn init<R: Runtime, C: DeserializeOwned>(
  _app: &AppHandle<R>,
  api: PluginApi<R, C>,
) -> crate::Result<MobileOnbackpressedListener<R>> {
  #[cfg(target_os = "android")]
  let handle = api.register_android_plugin(
    "tech.kingsword.tauri_plugins.mobile_onbackpressed_listener",
    "MobileOnBackPressedListenerPlugin",
  )?;
  #[cfg(target_os = "ios")]
  let handle = api.register_ios_plugin(init_plugin_mobile_onbackpressed_listener)?;
  Ok(MobileOnbackpressedListener(handle))
}

/// Access to the mobile-onbackpressed-listener APIs.
pub struct MobileOnbackpressedListener<R: Runtime>(PluginHandle<R>);

impl<R: Runtime> MobileOnbackpressedListener<R> {
  pub fn register_back_event(&self) -> crate::Result<()> {
    self.0.run_mobile_plugin("registerBackEvent", ()).map_err(Into::into)
  }
}
