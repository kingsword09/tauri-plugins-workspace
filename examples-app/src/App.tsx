import { useState } from "react";
import { BrowserRouter as Router, Routes, Route, Link } from "react-router-dom";
import { IosNetworkDetectDemo } from "./pages/IosNetworkDetectDemo.tsx";
import { MobileOnBackpressedListenerDemo } from "./pages/MobileOnBackpressedListenerDemo.tsx";
import "./App.css";

function App() {
  const [isDrawerOpen, setIsDrawerOpen] = useState(false);

  return (
    <Router>
      <main className="container">
        <button type="button" className="menu-button" onClick={() => setIsDrawerOpen(!isDrawerOpen)}>
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
              <Link to="/ios-network-detect" onClick={() => setIsDrawerOpen(false)}>
                iOS Network Detect
              </Link>
            </li>
            <li>
              <Link to="/mobile-onbackpressed-listener" onClick={() => setIsDrawerOpen(false)}>
                Mobile OnBackpressed Listener
              </Link>
            </li>
          </ul>
        </nav>

        {isDrawerOpen && <div className="overlay" onClick={() => setIsDrawerOpen(false)} />}

        <div className="content">
          <Routes>
            <Route path="/ios-network-detect" element={<IosNetworkDetectDemo />} />
            <Route path="/mobile-onbackpressed-listener" element={<MobileOnBackpressedListenerDemo />} />
            <Route path="/" element={<Home />} />
          </Routes>
        </div>
      </main>
    </Router>
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
