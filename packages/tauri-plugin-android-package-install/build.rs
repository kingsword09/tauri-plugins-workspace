const COMMANDS: &[&str] = &["install", "request_permissions", "check_permissions"];

fn main() {
  tauri_plugin::Builder::new(COMMANDS).android_path("android").build();
}
