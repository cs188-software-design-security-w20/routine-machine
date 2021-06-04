# Routine Machine

An encrypted habit tracker :)

## Getting Started

### Install Flutter
If you don't already have flutter installed, follow [these steps](https://flutter.dev/docs/get-started/install) to get it installed on your computer. 

### (Android users) Installing the APK's (CS188 testing group use this) 
Next, to run our project, make sure you are in the `Routine-Machine` directory. Then connect your Android device via USB cable. 

First to ensure you have downloaded the necessary dependencies for the project type:
```
flutter pub get
```

Next we will need to generate an `apk` file for your device. Type
```
flutter run --release
```
to generate a release build for the app. This will allow you to run the app while also seeing debug outputs in the terminal while your device is connected. Next to install the apk, type:
```
flutter install
```
This will uninstall the old apk and replace it with the build apk for your phone.

If you are running into keystore issues, you must configure a keystore for your device. 
To create a keystore type: 
```
keytool -genkey -v -keystore c:\Users\USER_NAME\upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```
Make sure you replace `USER_NAME` with your computers username. If this command doesn't work then check the [note](https://flutter.dev/docs/deployment/android#build-an-apk) in the docs. `keytool` might not be in your path and the _note_ section details how to fix this. 

Then under `Routine-Machine/android` folder create a file called `key.properties`. 
```
storePassword=<password from previous step>
keyPassword=<password from previous step>
keyAlias=upload
storeFile=<location of the key store file, such as /Users/<user name>/upload-keystore.jks>
```
Fill in the necessary information. 

### Testing/Debugging
If you are a developer and need to test the project, run the following commands. 
`cd Routine-Machine` if you haven't already. 

Next we must install the necessary packages needed for the project. Run:
```
flutter pub get
```
This will install all the dependencies for Routine Machine. Then to start project development, type:
```
flutter run
```
for debug mode or 
```
flutter run --release
```
for a release build. 

