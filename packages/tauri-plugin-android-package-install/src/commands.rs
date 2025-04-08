use tauri::{command, AppHandle, Runtime};

use crate::AndroidPackageInstallExt;
use crate::Result;

#[command]
pub(crate) async fn install<R: Runtime>(app: AppHandle<R>, install_path: String) -> Result<PingResponse> {
  app.android_package_install().install(install_path)
}
