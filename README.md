# 🚀 Duo App

**Duo App** is an in-progress mobile application prototype built with **Flutter**. It's designed as a learning project to explore best practices in Flutter app development, modular project organization, and integration with Firebase Authentication.  

This project is currently under active development and serves as a personal portfolio project to demonstrate my skills with Flutter, Riverpod state management, and service-layer abstraction for scalable app architecture.

---

## 📜 About This Project

The goal of **Duo App** is to create a simple but realistic mobile app with user authentication, clean navigation, and a modular codebase that's easy to maintain and scale.  

This repository showcases:

- A **feature-first** folder structure for separating concerns
- An early implementation of **Firebase initialization**
- Plans for a dedicated **service layer** to manage Firebase Auth
- Custom reusable UI components
- Themed app design for consistent styling

---

## ⚙️ Key Features (Planned / In Progress)

✅ Firebase Initialization  
✅ Sign-in form with email/password fields  
✅ Modular folder structure (core, features, product)  
✅ Navigation service with global navigator key  
✅ Custom form field components  
✅ Centralized theming  
✅ Service layer abstraction for Firebase Auth (planned)  
✅ Provider-based state management with Riverpod (planned)  
✅ Error handling and validation (planned)  
✅ User session management (planned)

---

## 🗂️ Project Structure Overview
- lib/
- ├── core/ # App-wide configs, constants, services
- │ ├── initialize/firebase_initialize.dart
- │ ├── navigation/navigation_service.dart
- │ └── constants/
- ├── features/ # App features (e.g. auth)
- │ └── auth/
- │ ├── view/
- │ └── ... (planned: services, providers)
- └── product/ # Shared widgets, design system, theme
- ├── design/
- └── theme/

---

## 🛠️ Tech Stack

- **Flutter** (Dart)
- **Firebase** (Firebase Core, Firebase Auth)
- **Riverpod** for state management (planned)
- **Material Design**
- **Custom reusable widgets**
- Modular and scalable folder structure

---

## 📸 Screenshots

*Note: UI is still in early development. Below are sample screenshots of current screens.*

<img src="https://github.com/user-attachments/assets/3a820719-fd36-4649-828f-c605a8dcec93" width="70%"/>
<img src="https://github.com/user-attachments/assets/525b6ab1-f1e1-4eb1-9e07-376af706b411" width="70%"/>
<img src="https://github.com/user-attachments/assets/e645d1c4-11c9-4f8f-b154-d6d682eb812d" width="70%"/>
<img src="https://github.com/user-attachments/assets/dd3b7a77-ab70-4d93-a64a-7ec234a7060b" width="70%"/>

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) installed
- Firebase project configured (for Firebase Auth)
- Emulator or physical device

### Installation

Clone the repository:

```bash
git clone https://github.com/gitomerbaran/duo_app.git
cd duo_app
flutter pub get
flutter run
```
