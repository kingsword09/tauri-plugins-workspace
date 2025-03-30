# Tauri Plugin mobile-onbackpressed-listener

[![JSR @kingsword09](https://jsr.io/badges/@kingsword09)](https://jsr.io/@kingsword09)
[![JSR](https://jsr.io/badges/@kingsword/tauri-plugin-mobile-onbackpressed-listener)](https://jsr.io/@kingsword/tauri-plugin-mobile-onbackpressed-listener)
[![Crates.io][crates-badge]][crates-url]

[crates-badge]: https://img.shields.io/crates/v/tauri-plugin-mobile-onbackpressed-listener
[crates-url]: https://crates.io/crates/tauri-plugin-mobile-onbackpressed-listener

| Platform | Supported |
| -------- | --------- |
| Linux    | x         |
| Windows  | x         |
| macOS    | x         |
| Android  | ✓         |
| iOS      | ✓         |

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
[target.'cfg(any(target_os = "ios", target_os = "android"))'.dependencies]
tauri-plugin-mobile-onbackpressed-listener = "2.0.0"
```

#### Automatically

use the cargo add command to install it automatically (mobile targets only)：

```bash
cargo add tauri-plugin-mobile-onbackpressed-listener --target 'cfg(any(target_os = "ios", target_os = "android"))'
```

## Usage

First you need to register the core plugin with Tauri: `src-tauri/src/lib.rs`

```rust
pub fn run() {
  tauri::Builder::default()
    .setup(|app| {
      #[cfg(any(target_os = "ios", target_os = "android"))]
      app.handle().plugin(tauri_plugin_mobile_onbackpressed_listener::init())?;

      Ok(())
    })
    .invoke_handler(tauri::generate_handler![greet])
    .run(tauri::generate_context!())
    .expect("error while running tauri application");
}
```

#### deno usage

```ts
import { registerBackEvent } from "jsr:@kingsword/tauri-plugin-mobile-onbackpressed-listener";
```

#### nodejs usage

1. update .npmrc

```diff
+ @jsr:registry=https://npm.jsr.io
```

2. install

```bash
npx jsr add @kingsword/tauri-plugin-mobile-onbackpressed-listener
```

3. usage

```ts
import { registerBackEvent } from "@jsr/kingsword__tauri-plugin-mobile-onbackpressed-listener";
```
or

```diff
// package.json
 {
   "type": "module",
   "dependencies": {
-    "@jsr/kingsword__tauri-plugin-mobile-onbackpressed-listener": "2.0.1"
+    "@kingsword/tauri-plugin-mobile-onbackpressed-listener": "npm:@jsr/kingsword__tauri-plugin-mobile-onbackpressed-listener@2.0.1"
   }
 }
```
```ts
import { registerBackEvent } from "@kingsword/tauri-plugin-mobile-onbackpressed-listener";
```
