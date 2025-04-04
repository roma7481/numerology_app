# numerology

A new Flutter application.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### Getting started with FVM

# 🚀 Flutter Project Setup with FVM (Flutter Version Management)

This project uses [FVM](https://fvm.app/) to manage Flutter versions per project. FVM ensures consistent builds and removes the need to switch Flutter versions globally when working on multiple projects.

# 1. Install FVM globally:
- bash
  dart pub global activate fvm

# 2. Add FVM to your system path:
- export PATH="$PATH":"$HOME/.pub-cache/bin"

# 3. Navigate to the project folder
- cd /path/to/your/project

# 4. Install the desired Flutter version for this project
- fvm install <flutter_version>   # Example: fvm install 3.22.2

# 5. Set the project to use that version
- fvm use <flutter_version> --force

# 6. Android Studio Configuration
* Open Android Studio
* Go to File > Settings > Languages & Frameworks > Flutter
* (on macOS: Android Studio > Preferences > Languages & Frameworks > Flutter)
* Set the Flutter SDK path to:
- <your_project_path>/.fvm/flutter_sdk

# 7. Xcode / iOS Setup
* Edit ios/Flutter/flutter_export_environment.sh and set replace the FLUTTER_ROOT like this:
- export "FLUTTER_ROOT=${PWD}/.fvm/flutter_sdk"
* Update Generated.xcconfig
  Edit ios/Flutter/Generated.xcconfig and replace any hardcoded FLUTTER_ROOT with:
- FLUTTER_ROOT=$(PROJECT_DIR)/../.fvm/flutter_sdk
* Clear and reinstall CocaPods
- cd ios
- rm -rf Pods Podfile.lock
- pod install

# 8. Add .fvm to .gitignore

