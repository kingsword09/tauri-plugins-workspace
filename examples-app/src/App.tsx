import React, { useState } from "react";
import { IosNetworkDetectDemo } from "./pages/IosNetworkDetectDemo.tsx";
import { MobileOnBackpressedListenerDemo } from "./pages/MobileOnBackpressedListenerDemo.tsx";
import "./App.css";

function App() {
  const [isDrawerOpen, setIsDrawerOpen] = useState(false);
  const [currentPage, setCurrentPage] = useState("home");

  const renderContent = () => {
    switch (currentPage) {
      case "ios-network-detect":
        return <IosNetworkDetectDemo />;
      case "mobile-onbackpressed-listener":
        return <MobileOnBackpressedListenerDemo />;
      default:
        return <Home />;
    }
  };

  return (
    <main className="container">
      <button className="menu-button" onClick={() => setIsDrawerOpen(!isDrawerOpen)}>
        <div className={`hamburger ${isDrawerOpen ? "open" : ""}`}>
          <span></span>
          <span></span>
          <span></span>
        </div>
      </button>

      <nav className={`drawer ${isDrawerOpen ? "open" : ""}`}>
        <h1>Tauri Plugins Demo</h1>
        <ul>
          <li>
            <a
              href="#"
              onClick={(e) => {
                e.preventDefault();
                setCurrentPage("ios-network-detect");
                setIsDrawerOpen(false);
              }}
            >
              iOS Network Detect
            </a>
            <a
              href="#"
              onClick={(e) => {
                e.preventDefault();
                setCurrentPage("mobile-onbackpressed-listener");
                setIsDrawerOpen(false);
              }}
            >
              Mobile OnBackpressed Listener
            </a>
          </li>
        </ul>
      </nav>

      {isDrawerOpen && <div className="overlay" onClick={() => setIsDrawerOpen(false)} />}

      <div className="content">{renderContent()}</div>
    </main>
  );
}

function Home() {
  return (
    <div>
      <h2>Tauri 插件演示</h2>
      <p>点击左上角菜单选择要测试的插件功能</p>
    </div>
  );
}

export default App;
