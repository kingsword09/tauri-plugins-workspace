const COMMANDS: &[&str] = &["install", "request_permissions", "check_permissions"];

fn main() {
  tauri_plugin::Builder::new(COMMANDS)
    .global_api_script_path("./api-iife.js")
    .android_path("android")
    .build();
}
