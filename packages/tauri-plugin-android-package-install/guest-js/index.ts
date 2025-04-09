import {
  invoke,
  checkPermissions as checkPermissions_,
  requestPermissions as requestPermissions_,
  type PermissionState,
} from "@tauri-apps/api/core";
export type { PermissionState } from "@tauri-apps/api/core";

export async function install(install_path: string): Promise<void> {
  return await invoke<void>("plugin:android-package-install|install", {
    install_path,
  });
}

/**
 * Get permission state.
 */
export async function checkPermissions(): Promise<PermissionState> {
  return await checkPermissions_<{ install: PermissionState }>("android-package-install").then((r) => r.install);
}

/**
 * Request permissions to use the camera.
 */
export async function requestPermissions(): Promise<PermissionState> {
  return await requestPermissions_<{ install: PermissionState }>("android-package-install").then((r) => r.install);
}
