package tech.kingsword.tauri_plugins.android_package_install

import android.app.Activity
import android.app.AlertDialog
import android.app.Dialog
import android.content.Intent
import android.os.Bundle
import android.provider.Settings
import androidx.core.net.toUri
import androidx.fragment.app.DialogFragment

class RequestInstallationPermissionDialog(
  private val activity: Activity,
  private val title: String,
  private val message: String,
  private val agree: String,
  private val disagree: String
) : DialogFragment() {

  override fun onCreateDialog(savedInstanceState: Bundle?): Dialog {

    return AlertDialog.Builder(activity)
      .setTitle(title)
      .setMessage(message)
      .setPositiveButton(agree) { dialog, _ ->
        dialog.dismiss()

        val uri = "package:${activity.packageName}".toUri()
        val requestPermission = Intent(Settings.ACTION_MANAGE_UNKNOWN_APP_SOURCES, uri)
        startActivity(requestPermission)
      }
      .setNegativeButton(disagree) { dialog, _ -> dialog.dismiss() }
      .create()
  }

  fun show() {
    show()
  }
}