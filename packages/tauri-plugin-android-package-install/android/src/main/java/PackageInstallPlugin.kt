package tech.kingsword.tauri_plugins.android_package_install

import android.app.Activity
import android.content.ActivityNotFoundException
import android.content.Intent
import android.widget.Toast
import androidx.core.content.FileProvider
import app.tauri.PermissionState
import app.tauri.annotation.Command
import app.tauri.annotation.InvokeArg
import app.tauri.annotation.TauriPlugin
import app.tauri.plugin.Invoke
import app.tauri.plugin.JSObject
import app.tauri.plugin.Plugin
import java.io.File

@InvokeArg
class PackageInstallOptions {
  lateinit var title: String
  lateinit var message: String
  lateinit var agree: String
  lateinit var disagree: String
}

@TauriPlugin
class PackageInstallPlugin(private val activity: Activity) : Plugin(activity) {
  @Command
  fun requestPermission(invoke: Invoke) {
    val args = invoke.parseArgs(PackageInstallOptions::class.java)

    RequestInstallationPermissionDialog(
      activity,
      args.title,
      args.message,
      args.agree,
      args.disagree
    ).show()

    invoke.resolve()
  }

  @Command
  fun checkPermission(invoke: Invoke) {
    val ret = JSObject()

    if (activity.packageManager.canRequestPackageInstalls()) {
      ret.put("packageInstall", PermissionState.GRANTED)
    } else {
      ret.put("packageInstall", PermissionState.DENIED)
    }

    invoke.resolve(ret)
  }

  @Command
  fun install(invoke: Invoke) {
    val installPath = invoke.parseArgs(String::class.java)

    val apkFile = File(installPath)
    val apkUri =
      FileProvider.getUriForFile(activity, "${activity.packageName}.fileprovider", apkFile)
    val installIntent = Intent(Intent.ACTION_VIEW).apply {
      setDataAndType(apkUri, "application/vnd.android.package-archive")
      addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
      addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
    }

    try {
      activity.startActivity(installIntent)
    } catch (e: ActivityNotFoundException) {
      Toast.makeText(activity, "Not Found Apk.", Toast.LENGTH_SHORT).show()
    } catch (e: SecurityException) {
      Toast.makeText(activity, "Permission Denies.", Toast.LENGTH_SHORT).show()
    }
  }
}
