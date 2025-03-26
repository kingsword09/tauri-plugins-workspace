use tauri::{command, AppHandle, Runtime};

use crate::MobileOnbackpressedListenerExt;
use crate::Result;

#[command]
pub(crate) async fn register_back_event<R: Runtime>(app: AppHandle<R>) -> Result<()> {
  app.mobile_onbackpressed_listener().register_back_event()
}
