# mobilellc_task

A new Flutter application.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Supported devices.
Any device who support android sdk > 29
## Supported features.
User can Search Track
User can See List of Track
User can Play Track
User can Pause Track
User can Stop Track
## Requirements to build the app.
Need to do all flutter project settings and run the flutter project
## Instructions to build and deploy the app.
Step 1
Increase version no in pubspec.yaml
Step 2
Right click on Android folder inside Flutter project and open in android studio
Step 3
Crosscheck versionname and version code with step 0
It’s Local.properties file present in Gradle Scripts folder
Step 4
Now  click on 
Build -> Generate Signed Bundle / APK
Step 5
Choose appropriate build for release Android App Bundle or APK and click on Next
Step 6
Choose keystore file and details
If you are doing first time then create new one or u can use existing one also
Keep in mind Further builds should be used same keystore file
Step 7
Choose release for Play store deployment and click on finish
Step 8
It generates either apk file or aab file depending on Step 5

## Now upload this file into playstore console release management
Step 9
Click on App releases
Then click on Manage Production Track to release it on production
Then click on create release
Step 10
Now fill all relevant information and upload build (aab or apk ) generated at step 11
Then click on review then start rollout button @ bottom
Step 12
Voila it’s done