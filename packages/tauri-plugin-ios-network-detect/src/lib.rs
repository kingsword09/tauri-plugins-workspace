use tauri::{
  plugin::{Builder, TauriPlugin},
  Manager, Runtime,
};

#[cfg(target_os = "ios")]
mod mobile;

mod error;

pub use error::{Error, Result};

#[cfg(target_os = "ios")]
use mobile::IosNetworkDetect;

/// Extensions to [`tauri::App`], [`tauri::AppHandle`] and [`tauri::Window`] to access the ios-network-detect APIs.
pub trait IosNetworkDetectExt<R: Runtime> {
  fn ios_network_detect(&self) -> &IosNetworkDetect<R>;
}

impl<R: Runtime, T: Manager<R>> crate::IosNetworkDetectExt<R> for T {
  fn ios_network_detect(&self) -> &IosNetworkDetect<R> {
    self.state::<IosNetworkDetect<R>>().inner()
  }
}

/// Initializes the plugin.
pub fn init<R: Runtime>() -> TauriPlugin<R> {
  Builder::new("ios-network-detect")
    .setup(|app, api| {
      #[cfg(target_os = "ios")]
      let ios_network_detect = mobile::init(app, api)?;
      app.manage(ios_network_detect);
      Ok(())
    })
    .build()
}
