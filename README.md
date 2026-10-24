# Flutter-App
Feat: From basic to Advanced Level Flutter on Dart
# Lost & Found @ CUI

A Flutter mobile app that helps students and teachers of COMSATS University Islamabad, Sahiwal Campus report and find lost items on campus.

> **Status: In progress.** The first screens are done. The main features (posting and searching items) are being built.

## The Problem
When someone loses something on campus, there is no single place to report it or search for it. This app aims to give the whole campus one safe and simple place to do that.

## Current Progress
- **Onboarding:** 5 animated intro pages with Skip and Next buttons that explain the app's idea
- **Login / Sign Up:** one screen that switches between Sign In and Create Account
  - Student or Teacher selection
  - Registration number check (format: `SP25-BCS-001`)
  - Department dropdown
  - Email check, password check (minimum 8 characters) and confirm password
  - Show / hide password button
- **Design:** custom colour theme (Material 3) and an animated floating-bubble background

> Note: Sign In and Sign Up are currently a UI demo. Backend and database are not connected yet.

## Planned Features
- Post a lost or found item
- Mark the exact place on campus where it was lost or found
- Search and browse items
- Verified claims: only the real owner can claim an item by answering a secret question
- Privacy: phone number stays hidden, with secure in-app chat
- "Campus Hero" points and badges for returning items

## Tech Stack
- Flutter
- Dart
- Material 3

## Project Structure
lib/
- main.dart: app entry point
- core/app_theme.dart: colours and theme
- screens/onboarding_screen.dart: intro pages
- screens/login_screen.dart: sign in and sign up
- widgets/floating_background.dart: animated background

## How to Run
1. Install [Flutter](https://docs.flutter.dev/get-started/install)
2. Clone this repository
3. Run `flutter pub get`
4. Run `flutter run`

## Screenshots
Also Added

## Author
Moazma Imam
BSCS Student, COMSATS University Islamabad, Sahiwal Campus
GitHub: [Moazma31](https://github.com/Moazma31)
