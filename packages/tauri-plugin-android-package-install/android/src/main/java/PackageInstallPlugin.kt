package tech.kingsword.tauri_plugins.android_package_install

import android.Manifest
import android.app.Activity
import android.content.ActivityNotFoundException
import android.content.Intent
import android.os.Handler
import android.os.Looper
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.FileProvider
import app.tauri.PermissionState
import app.tauri.annotation.Command
import app.tauri.annotation.Permission
import app.tauri.annotation.PermissionCallback
import app.tauri.annotation.TauriPlugin
import app.tauri.plugin.Invoke
import app.tauri.plugin.JSObject
import app.tauri.plugin.Plugin
import java.io.File

internal const val PERMISSION_ALIAS_INSTALL = "install"
private const val PERMISSION_NAME = Manifest.permission.REQUEST_INSTALL_PACKAGES

@TauriPlugin(
  permissions = [
    Permission(strings = [PERMISSION_NAME], alias = PERMISSION_ALIAS_INSTALL)
  ]
)
class PackageInstallPlugin(private val activity: Activity) : Plugin(activity) {
  private var requestPermissionResponse: JSObject? = null

  @PermissionCallback
  fun installPermissionCallback(invoke: Invoke) {
    if (requestPermissionResponse == null) {
      return
    }

    val requestPermissionResponse = requestPermissionResponse!!
    println("QAQ canRequestPackageInstalls = ${activity.packageManager.canRequestPackageInstalls()}")

    val granted = getPermissionState(PERMISSION_ALIAS_INSTALL) === PermissionState.GRANTED

    if (granted || activity.packageManager.canRequestPackageInstalls()) {
      requestPermissionResponse.put(PERMISSION_ALIAS_INSTALL, PermissionState.GRANTED)
    } else {
      requestPermissionResponse.put(PERMISSION_ALIAS_INSTALL, PermissionState.DENIED)
    }

    invoke.resolve(requestPermissionResponse)
    this.requestPermissionResponse = null
  }

  @Command
  override fun requestPermissions(invoke: Invoke) {
    val requestPermissionResponse = JSObject()
    this.requestPermissionResponse = requestPermissionResponse
    if (getPermissionState(PERMISSION_ALIAS_INSTALL) === PermissionState.GRANTED) {
      requestPermissionResponse.put(PERMISSION_ALIAS_INSTALL, PermissionState.GRANTED)
    } else {
      Handler(Looper.getMainLooper())
        .post {
          RequestInstallationPermissionDialog(
            activity,
            handle!!,
            invoke,
            "installPermissionCallback"
          ).show((activity as AppCompatActivity).supportFragmentManager)
        }
      return
    }

    invoke.resolve(requestPermissionResponse)
  }

  @Command
  override fun checkPermissions(invoke: Invoke) {
    if (activity.packageManager.canRequestPackageInstalls()) {
      val requestPermissionResponse = JSObject()
      requestPermissionResponse.put(PERMISSION_ALIAS_INSTALL, PermissionState.GRANTED)
      invoke.resolve(requestPermissionResponse)
    } else {
      super.checkPermissions(invoke)
    }
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
      Toast.makeText(
        activity,
        R.string.request_installation_permission_dialog__no_found_apk,
        Toast.LENGTH_SHORT
      ).show()
    } catch (e: SecurityException) {
      Toast.makeText(
        activity,
        R.string.request_installation_permission_dialog__permission_denies,
        Toast.LENGTH_SHORT
      ).show()
    }
  }
}
