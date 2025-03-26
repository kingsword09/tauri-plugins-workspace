package tech.kingsword.tauri_plugins.mobile_onbackpressed_listener

import android.app.Activity
import android.os.Build
import android.webkit.WebView
import android.window.OnBackInvokedDispatcher
import androidx.activity.OnBackPressedCallback
import androidx.appcompat.app.AppCompatActivity
import app.tauri.annotation.Command
import app.tauri.annotation.TauriPlugin
import app.tauri.plugin.Invoke
import app.tauri.plugin.JSObject
import app.tauri.plugin.Plugin

@TauriPlugin
class MobileOnBackPressedListenerPlugin(private val activity: Activity) : Plugin(activity) {
  private val onBackPressedCallback = object : OnBackPressedCallback(true) {
    override fun handleOnBackPressed() {
      onBackPressed()
    }
  }

  private val onBackInvokedCallback = {
    onBackPressed()
  }

  override fun load(webView: WebView) {
    super.load(webView)

    if (activity is AppCompatActivity) {
      activity.onBackPressedDispatcher.addCallback(onBackPressedCallback)
      
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
        activity.onBackInvokedDispatcher.registerOnBackInvokedCallback(
          OnBackInvokedDispatcher.PRIORITY_DEFAULT, onBackInvokedCallback
        )
      }
    }
  }

  private fun onBackPressed() {
    trigger("mobile-onbackpressed-goback", JSObject())
  }

  @Command
  fun registerBackEvent(invoke: Invoke) {
    invoke.resolve()
  }
}
