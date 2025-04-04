import { useNavigate } from "react-router-dom";
import { registerBackEvent } from "@kingsword/tauri-plugin-mobile-onbackpressed-listener";
import type { PluginListener } from "@tauri-apps/api/core";

let isListener = false;
let listener: PluginListener | undefined;

export function MobileOnBackpressedListenerDemo() {
  const navigate = useNavigate();

  const listenerBackButton = (callback: () => void) => {
    if (isListener) return;
    isListener = true;
    const listenerClose = async () => {
      listener = await registerBackEvent(callback);
    };
    listenerClose();
  };

  const registerBackEventToBack = () => {
    listenerBackButton(async () => {
      navigate(-1); // 返回上一页
      isListener = false;
      if (listener) {
        await listener.unregister();
      }
    });
  };

  return (
    <div>
      <h2>mobile onbackpressed listener</h2>
      <button type="button" onClick={registerBackEventToBack}>
        注册返回事件
      </button>
    </div>
  );
}
