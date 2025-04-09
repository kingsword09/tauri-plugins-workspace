package tech.kingsword.tauri_plugins.android_package_install

import android.app.Activity
import android.app.AlertDialog
import android.app.Dialog
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Bundle
import android.provider.Settings
import androidx.core.net.toUri
import androidx.fragment.app.DialogFragment
import androidx.fragment.app.FragmentManager
import app.tauri.PermissionState
import app.tauri.plugin.Invoke
import app.tauri.plugin.JSObject
import app.tauri.plugin.PluginHandle

class RequestInstallationPermissionDialog(
  private val activity: Activity,
  private val handle: PluginHandle,
  private val invoke: Invoke,
  private val callbackName: String
) : DialogFragment() {
  private var appName: String

  init {
    val packageManager = activity.packageManager
    val appInfo =
      packageManager.getApplicationInfo(activity.packageName, PackageManager.GET_META_DATA)
    appName = appInfo.loadLabel(packageManager).toString()
  }

  override fun onCreateDialog(savedInstanceState: Bundle?): Dialog {
    return AlertDialog.Builder(activity)
      .setTitle(R.string.request_installation_permission_dialog__title)
      .setMessage(getString(R.string.request_installation_permission_dialog__message, appName))
      .setPositiveButton(R.string.request_installation_permission_dialog__grant_permission) { dialog, _ ->
        dialog.dismiss()

        val uri = "package:${activity.packageName}".toUri()
        val requestPermission = Intent(Settings.ACTION_MANAGE_UNKNOWN_APP_SOURCES, uri)
        handle.startActivityForResult(invoke, requestPermission, callbackName)
      }
      .setNegativeButton(R.string.request_installation_permission_dialog__abort) { dialog, _ ->
        dialog.dismiss()
        val requestPermissionResponse = JSObject()
        requestPermissionResponse.put(PERMISSION_ALIAS_INSTALL, PermissionState.DENIED)
        invoke.resolve(requestPermissionResponse)
      }
      .create()
  }

  fun show(manager: FragmentManager) {
    show(manager, appName)
  }
}