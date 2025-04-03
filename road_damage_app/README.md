# Road Damage Detection - Flutter WebView App

This project wraps a **Streamlit-based road damage detection app** inside a Flutter mobile application using WebView. It includes support for:
- Camera access for real-time damage detection
- File uploads using Streamlit's file picker
- Permissions for camera, microphone, and file access

## 🚀 Features
- ✅ **Runs Streamlit Web App** inside Flutter
- ✅ **Enables Camera & Microphone** for real-time detection
- ✅ **Allows File Uploads** in WebView
- ✅ **Supports Android & iOS**

---

## 📌 Prerequisites
Ensure you have the following installed:
- **Flutter SDK** (latest version)
- **Android Studio or Xcode** (for Android/iOS development)
- **A Running Streamlit Web App** (hosted online or locally)

---

## 🔹 1. Clone the Repository
```bash
https://github.com/Ni1esh-Yadav/Road-Damage-flutter.git
cd Road-Damage-flutter than cd road_damage_app
```

---

## 🔹 2. Update `pubspec.yaml`
Add dependencies for WebView and permissions:
```yaml
dependencies:
  flutter:
    sdk: flutter
  webview_flutter: ^4.4.4
  webview_flutter_android: ^3.12.0
  webview_flutter_wkwebview: ^3.9.0
  permission_handler: ^11.3.1
```
Then run:
```bash
flutter pub get
```

---

## 🔹 3. Modify `main.dart`
Update your `lib/main.dart` file with the following:
```dart
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WebViewContainer(),
    );
  }
}

class WebViewContainer extends StatefulWidget {
  const WebViewContainer({super.key});

  @override
  _WebViewContainerState createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
    _setupWebView();
  }

  Future<void> _requestPermissions() async {
    await Permission.camera.request();
    await Permission.microphone.request();
    await Permission.storage.request();
  }

  void _setupWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPermissionRequest: (request) async {
            if (request.types.contains(PermissionType.camera) || request.types.contains(PermissionType.microphone)) {
              request.grant();
            }
          },
        ),
      )
      ..loadRequest(Uri.parse("https://your-streamlit-app-url.com")); // Replace with your Streamlit URL
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Road Damage Detection")),
      body: WebViewWidget(controller: _controller),
    );
  }
}
```

---

## 🔹 4. Modify `AndroidManifest.xml`
Enable camera, microphone, and file access in `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.RECORD_AUDIO"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
<uses-feature android:name="android.hardware.camera" android:required="true"/>

<application
    android:usesCleartextTraffic="true"
    android:requestLegacyExternalStorage="true">
    <meta-data android:name="android.webkit.WebView.WebRTC" android:value="true"/>
</application>
```

---

## 🔹 5. Modify `Info.plist` (For iOS)
For iOS, update `ios/Runner/Info.plist`:
```xml
<key>NSCameraUsageDescription</key>
<string>We need camera access to capture road damage images.</string>
<key>NSMicrophoneUsageDescription</key>
<string>We need microphone access for audio input.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>We need access to your photos for file uploads.</string>
```

---

## 🔹 6. Build & Run the App
Run the following command to clean and build the project:
```bash
flutter clean
flutter pub get
flutter run
```

If you are testing on **Android**, you may need to grant permissions manually:
1. Go to **Android Settings → Apps → Your App → Permissions**
2. Enable **Camera, Microphone, and Storage**

---

## 🎯 Troubleshooting
| Issue | Solution |
|-----------------|-------------------------------------------------|
| `NotAllowedError: Permission Denied` | Ensure camera & mic permissions are enabled manually in settings. |
| File picker not working | Use **drag-and-drop** file uploads in Streamlit instead. |
| WebView not loading | Check if your Streamlit app is hosted and accessible. |

---

## 🎉 Conclusion
Your **Flutter WebView** app is now set up to:
✅ Load your Streamlit app inside a mobile app.  
✅ Enable camera & mic for real-time detection.  
✅ Support file uploads.  
✅ Run on **Android & iOS**.  

Let me know if you need further improvements! 🚀

