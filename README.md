# QuickChat: Real-Time Flutter Chat Application

A lightweight, cross-platform mobile chat application built with Flutter and powered by Firebase. The application enables seamless real-time messaging where users interact instantly using unique usernames, backed by a secure and accessible account management system.

---

## 🚀 Features

* **Username-Based Chatting:** No complex exchange of phone numbers or personal data; users identify and message each other seamlessly using their custom usernames.
* **Real-Time Messaging:** Instant message delivery and synchronized chat feeds powered by Firebase Cloud Firestore.
* **Account Accessibility & Management:** Easy account creation, secure login, password resets, and persistence across devices.
* **Media Sharing:** Scalable storage configuration ready to support profile image uploads and chat attachments via Firebase Storage.
* **Cross-Platform:** Beautiful, responsive UI designed to look and run natively on both iOS and Android from a single codebase.

---

## 🛠️ Tech Stack

### Frontend
* **Framework:** Flutter (Dart)
* **UI Components:** Material Design / Cupertino widgets

### Backend & Infrastructure
* **Authentication:** Firebase Authentication (Email/Password & Username handling)
* **Database:** Firebase Cloud Firestore (Real-time NoSQL document database)
* **Storage:** Firebase Storage (For profile pictures and shared media files)

---
## Samples
<img src="/Screenshot 2026-05-16 211438.png" alt="Instagram Clone Preview" width="350" />
<img src="/Screenshot 2026-05-16 211456.png" alt="Instagram Clone Preview" width="350" />
<img src="/Screenshot 2026-05-16 211510.png" alt="Instagram Clone Preview" width="350" />
<img src="/Screenshot 2026-05-16 211522.png" alt="Instagram Clone Preview" width="350" />


## 📁 File Structure

```text
quickchat-app/
├── android/                  # Native Android configuration files
├── ios/                      # Native iOS configuration files
├── lib/                      # Core Dart application code
│   ├── models/               # Data models (User, Message)
│   ├── screens/              # UI Screens (Login, Register, ChatRoom, Profile)
│   ├── services/             # Firebase Auth and Firestore helper logic
│   ├── widgets/              # Reusable UI components (Message Bubbles, Input Fields)
│   └── main.dart             # Application entry point
├── pubspec.yaml              # Flutter dependencies and asset tracking
└── README.md                 # Project documentation
⚙️ Simple Installation & Setup
Getting the application up and running on your local machine is simple and straightforward.

Prerequisites
Before you begin, ensure you have the following installed:

Flutter SDK (Latest stable version)

Dart SDK (Bundled with Flutter)

An Android Emulator, iOS Simulator, or a physical debugging device.

1. Clone the Repository
Bash
git clone <your-github-repo-url>
cd quickchat-app
2. Connect to Your Firebase Project
Because this app relies on Firebase, you need to link it to your own Firebase console:

Go to the Firebase Console and create a new project.

Enable Email/Password Authentication.

Create a Cloud Firestore database in test mode.

Create a Firebase Storage bucket.

Use the FlutterFire CLI to automatically configure your app dependencies:

Bash
dart pub global activate flutterfire_cli
flutterfire configure
This command will automatically generate the required firebase_options.dart file inside your lib/ directory.

3. Install Dependencies
Fetch all the required packages listed in the pubspec.yaml file:

Bash
flutter pub get
4. Run the Application
Connect your device/emulator and execute the run command:

Bash
flutter run
🔒 Security & Rules
To keep your chat platform secure, make sure to update your Cloud Firestore Rules in the Firebase console to ensure users can only write messages if they are fully authenticated:

JavaScript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /messages/{messageId} {
      allow read, write: if request.auth != null;
    }
  }
}
