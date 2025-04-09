import {
  install,
  requestPermissions,
  checkPermissions,
  type PermissionState,
} from "@kingsword/tauri-plugin-android-package-install";

export function AndroidPackageInstallDemo() {
  const checkPermission = async () => {
    const permissionState: PermissionState = await checkPermissions();
    console.log("checkPermission", permissionState);
  };
  const requestPermission = async () => {
    const permissionState: PermissionState = await requestPermissions();
    console.log("requestPermission", permissionState);
  };
  const installApp = async () => {
    await install("/data/0/tech.kingsword.tauri.example.app/apk/app-release.apk");
  };

  return (
    <div>
      <h2>android package install</h2>
      <button
        type="button"
        onClick={async () => {
          await checkPermission();
        }}
      >
        检查权限
      </button>
      <button
        type="button"
        onClick={async () => {
          await requestPermission();
        }}
      >
        请求权限
      </button>
      <button
        type="button"
        onClick={async () => {
          await installApp();
        }}
      >
        安装
      </button>
    </div>
  );
}
