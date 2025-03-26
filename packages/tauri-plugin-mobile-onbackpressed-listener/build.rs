const COMMANDS: &[&str] = &["register_back_event", "registerListener", "remove_listener"];

fn main() {
  tauri_plugin::Builder::new(COMMANDS)
    .global_api_script_path("./api-iife.js")
    .android_path("android")
    .ios_path("ios")
    .build();
}
