import { addPluginListener, invoke, type PluginListener } from "@tauri-apps/api/core";

export async function registerBackEvent(goBack: () => void): Promise<PluginListener> {
  await invoke("plugin:mobile-onbackpressed-listener|register_back_event");

  // Then register the event listener
  return await addPluginListener("mobile-onbackpressed-listener", "mobile-onbackpressed-goback", (_) => {
    goBack();
  });
}
