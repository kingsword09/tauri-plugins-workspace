#![cfg(target_os = "android")]

use tauri::{
  plugin::{Builder, TauriPlugin},
  Manager, Runtime,
};

mod mobile;

mod commands;
mod error;

pub use error::{Error, Result};

use mobile::AndroidPackageInstall;

/// Extensions to [`tauri::App`], [`tauri::AppHandle`] and [`tauri::Window`] to access the android-package-install APIs.
pub trait AndroidPackageInstallExt<R: Runtime> {
  fn android_package_install(&self) -> &AndroidPackageInstall<R>;
}

impl<R: Runtime, T: Manager<R>> crate::AndroidPackageInstallExt<R> for T {
  fn android_package_install(&self) -> &AndroidPackageInstall<R> {
    self.state::<AndroidPackageInstall<R>>().inner()
  }
}

/// Initializes the plugin.
pub fn init<R: Runtime>() -> TauriPlugin<R> {
  Builder::new("android-package-install")
    .invoke_handler(tauri::generate_handler![commands::install])
    .setup(|app, api| {
      let android_package_install = mobile::init(app, api)?;
      app.manage(android_package_install);
      Ok(())
    })
    .build()
}
