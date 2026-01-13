# Endless Scrolling (SwiftUI)

A SwiftUI-based iOS project demonstrating endless scrolling functionality with animated GIF support using **Gifu** and the **GIPHY API**.

---

## 🚀 Features

- Built with **SwiftUI**
- Endless scrolling experience
- GIF rendering using **Gifu**
- Data powered by **GIPHY API**

---

## 🛠 Requirements

- Xcode 15 or later
- iOS 17 SDK or later (device or simulator)
- A GIPHY API key 

---

## 📦 Dependencies

This project uses the following third-party library:

- **Gifu**
  - Version: **4.0.1+**
  - Used for displaying animated GIFs efficiently

> Make sure all dependencies are properly installed before running the project.

---

## 🔐 Configuration (Required)

To run this project, you must create a configuration file with your GIPHY API key.

### 1. Create `secret-config.plist`

In the project root directory:


### 2. Add the following key-value pair

| Key             | Type   | Value                    |
|-----------------|--------|--------------------------|
| GIPHY_API_KEY   | String | YOUR_GIPHY_API_KEY_HERE  |

### 3. Obtain a GIPHY API Key

You can get your API key from:

👉 https://api.giphy.com/v1/

Replace `YOUR_GIPHY_API_KEY_HERE` with your own key.

> ⚠️ **Important:**  
> Do **not** commit `secret-config.plist` to source control.  
> Make sure it is added to `.gitignore`.

---

## ▶️ Running the Project

1. Clone the repository
2. Open the project in **Xcode**
3. Ensure `secret-config.plist` exists and is correctly configured
4. Build and run on a simulator or physical device

---

## 🧪 Troubleshooting

- **GIFs not loading?**
  - Verify your `GIPHY_API_KEY` is valid
  - Ensure `secret-config.plist` is included in the app target
- **Build errors related to Gifu?**
  - Confirm the installed version is **4.0.1 or higher**

---

## 📄 License

This project is provided for educational and demonstration purposes.  
Feel free to modify and extend it as needed.

---

## 🙌 Acknowledgements

- [Gifu](https://github.com/kaishin/Gifu)
- [GIPHY Developers](https://developers.giphy.com/)

