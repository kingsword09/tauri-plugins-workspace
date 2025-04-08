use serde::de::DeserializeOwned;
use tauri::{
  plugin::{PluginApi, PluginHandle},
  AppHandle, Runtime,
};

// initializes the Kotlin or Swift plugin classes
pub fn init<R: Runtime, C: DeserializeOwned>(
  _app: &AppHandle<R>,
  api: PluginApi<R, C>,
) -> crate::Result<AndroidPackageInstall<R>> {
  #[cfg(target_os = "android")]
  let handle = api.register_android_plugin(
    "tech.kingsword.tauri_plugins.android_package_install",
    "PackageInstallPlugin",
  )?;
  Ok(AndroidPackageInstall(handle))
}

/// Access to the android-package-install APIs.
pub struct AndroidPackageInstall<R: Runtime>(PluginHandle<R>);

impl<R: Runtime> AndroidPackageInstall<R> {
  pub fn install(&self, install_path: String) -> crate::Result<PingResponse> {
    self.0.run_mobile_plugin("install", install_path).map_err(Into::into)
  }
}
