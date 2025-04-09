# Tauri Plugin android-package-install

[![Crates.io][crates-badge]][crates-url]

[crates-badge]: https://img.shields.io/crates/v/tauri-plugin-android-package-install
[crates-url]: https://crates.io/crates/tauri-plugin-android-package-install

| Platform | Supported |
| -------- | --------- |
| Linux    | x         |
| Windows  | x         |
| macOS    | x         |
| Android  | ✓         |
| iOS      | x         |

## Install

_This plugin requires a Rust version of at least **1.77.2**_

There are three general methods of installation that we can recommend.

1. Use crates.io and npm (easiest, and requires you to trust that our publishing pipeline worked)
2. Pull sources directly from Github using git tags / revision hashes (most secure)
3. Git submodule install this repo in your tauri project and then use file protocol to ingest the source (most secure,
   but inconvenient to use)

Install the Core plugin by adding the following to your `Cargo.toml` file:

`src-tauri/Cargo.toml`

#### Manually

```toml
[target.'cfg(any(target_os = "android"))'.dependencies]
tauri-plugin-android-package-install = "2.0.0"
```

#### Automatically

use the `cargo add` command to install it automatically (android target only)：

```bash
cargo add tauri-plugin-android-package-install --target 'cfg(target_os = "android")'
```

## Usage

First you need to register the core plugin with Tauri:

`src-tauri/src/lib.rs`

```rust
pub fn run() {
  tauri::Builder::default()
    .setup(|app| {
      #[cfg(target_os = "android")]
      app.handle().plugin(tauri_plugin_android_package_install::init())?;

      Ok(())
    })
    .plugin(tauri_plugin_opener::init())
    .invoke_handler(tauri::generate_handler![greet])
    .run(tauri::generate_context!())
    .expect("error while running tauri application");
}
```

#### deno usage

```ts
import { checkPermissions, requestPermissions, install } from "jsr:@kingsword/tauri-plugin-android-package-install";
```

#### nodejs usage

1. update .npmrc

```diff
+ @jsr:registry=https://npm.jsr.io
```

2. install

```bash
npx jsr add @kingsword/tauri-plugin-android-package-install
```

3. usage

```ts
import { checkPermissions, requestPermissions, install } from "@jsr/kingsword__tauri-plugin-android-package-install";
```

or

```diff
// package.json
 {
   "type": "module",
   "dependencies": {
-    "@jsr/kingsword__tauri-plugin-android-package-install": "2.0.0"
+    "@kingsword/tauri-plugin-android-package-install": "npm:@jsr/kingsword__tauri-plugin-android-package-install@2.0.0"
   }
 }
```

```ts
import { checkPermissions, requestPermissions, install } from "@kingsword/tauri-plugin-android-package-install";
```
