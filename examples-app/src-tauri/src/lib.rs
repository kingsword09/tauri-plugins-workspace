// Learn more about Tauri commands at https://tauri.app/develop/calling-rust/
#[tauri::command]
fn greet(name: &str) -> String {
  format!("Hello, {}! You've been greeted from Rust!", name)
}

#[cfg_attr(mobile, tauri::mobile_entry_point)]
pub fn run() {
  tauri::Builder::default()
    .setup(|app| {
      #[cfg(target_os = "android")]
      app.handle().plugin(tauri_plugin_android_package_install::init())?;

      #[cfg(target_os = "ios")]
      app.handle().plugin(tauri_plugin_ios_network_detect::init())?;

      #[cfg(any(target_os = "ios", target_os = "android"))]
      app
        .handle()
        .plugin(tauri_plugin_mobile_onbackpressed_listener::init())?;

      Ok(())
    })
    .plugin(tauri_plugin_opener::init())
    .invoke_handler(tauri::generate_handler![greet])
    .run(tauri::generate_context!())
    .expect("error while running tauri application");
}
