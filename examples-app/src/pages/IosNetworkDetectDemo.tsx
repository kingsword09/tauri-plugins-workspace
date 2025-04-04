import { useState } from "react";

export function IosNetworkDetectDemo() {
  const [status, setStatus] = useState<string>("");

  const checkNetworkPermission = () => {
    try {
      // 这里添加插件的调用代码
      setStatus("检查网络权限...");
    } catch (error) {
      setStatus(`错误: ${error}`);
    }
  };

  return (
    <div>
      <h2>iOS 网络权限检测</h2>
      <div className="demo-container">
        <button type="button" onClick={checkNetworkPermission}>检测网络权限</button>
        <p>状态: {status}</p>
      </div>
    </div>
  );
}
