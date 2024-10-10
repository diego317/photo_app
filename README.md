# Photo App

A Flutter application for capturing and viewing photos using the Camera Awesome package.

## Purpose

This app allows users to take photos using their device's camera and apply various filters to enhance the images. It serves as a practical example of using the Camera Awesome plugin in Flutter, demonstrating how to handle media capture and file management.

## Getting Started

To run this project, follow these steps:

1. **Clone the repository**:
  ```bash
  git clone <repository-url>
  cd photo_app
  ```

2. **Update Dependencies**: 
  If you encounter issues with awesome_filter_selector.dart or carousel_slider.dart, make sure to update the following lines in those files:

  In `awesome_filter_selector.dart` and `carousel_slider.dart`, add this import statement:

  ```dart
  import 'package:flutter/material.dart' hide CarouselController;
  ```

3. **Install Flutter Dependencies**:
 Run the following command to install the required dependencies:

  ```bash
  flutter pub get
  ```

4.**Run the App**: 
You can run the app on a physical device (iOS or Android) or in an emulator:

  ```bash
  flutter run
  ```