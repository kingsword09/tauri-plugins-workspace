use tauri::{
  plugin::{Builder, TauriPlugin},
  Manager, Runtime,
};

#[cfg(mobile)]
mod mobile;

mod commands;
mod error;

pub use error::{Error, Result};

#[cfg(mobile)]
use mobile::MobileOnbackpressedListener;

/// Extensions to [`tauri::App`], [`tauri::AppHandle`] and [`tauri::Window`] to access the mobile-onbackpressed-listener APIs.
pub trait MobileOnbackpressedListenerExt<R: Runtime> {
  fn mobile_onbackpressed_listener(&self) -> &MobileOnbackpressedListener<R>;
}

impl<R: Runtime, T: Manager<R>> crate::MobileOnbackpressedListenerExt<R> for T {
  fn mobile_onbackpressed_listener(&self) -> &MobileOnbackpressedListener<R> {
    self.state::<MobileOnbackpressedListener<R>>().inner()
  }
}

/// Initializes the plugin.
pub fn init<R: Runtime>() -> TauriPlugin<R> {
  Builder::new("mobile-onbackpressed-listener")
    .invoke_handler(tauri::generate_handler![commands::register_back_event])
    .setup(|app, api| {
      #[cfg(mobile)]
      let mobile_onbackpressed_listener = mobile::init(app, api)?;
      app.manage(mobile_onbackpressed_listener);
      Ok(())
    })
    .build()
}
