import React from "react";
import { registerBackEvent } from "@kingsword/tauri-plugin-mobile-onbackpressed-listener";

let isListener = false;
export function MobileOnBackpressedListenerDemo() {
  // const navigate = useNavigate();

  
  const listenerBackButton = (callback: () => void) => {
    if (isListener) return;
    isListener = true;
    const listenerClose = async () => {
      const listener = await registerBackEvent(callback);
      // await listener.unregister();
      isListener = false;
    };
    listenerClose();
  };

  const registerBackEventToBack = async () => {
    listenerBackButton(() => {
      console.log("1111")
    })
  };

  return (
    <div>
      <h2>mobile onbackpressed listener</h2>
      <button onClick={registerBackEventToBack}>注册返回事件</button>
    </div>
  );
}
