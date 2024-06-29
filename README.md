# petratest

Petra test project

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Tutorial
If you want to try our project locally, watch below:
Firstly clone this repository https://github.com/Nitsu47/Petra.git
You need to install some tools to support the technologies used:
1 Android SDK: https://developer.android.com/tools
2 Android Studio: https://developer.android.com/studio
3 Visual Studio: https://visualstudio.microsoft.com/es/downloads/
4 Visual Studio Code: https://code.visualstudio.com
5 Python 3: https://www.python.org/downloads/
6 Flask: on terminal: pip install Flask
After you have downloaded the tools, a configuration is necesary.
For the first, we need to put the route of the Android SDK into the path, to do this, be sure where is the folder containing the SDK, open the environment variables menu and add to the path, the route of the Android SDK.
To try the app in an emulator, you need to have the previous technologies and follow the next steps:
1 In Android Studio, go to customization section and press on the emulator section
2 Here you have to configure your emulator, select the phone model and Android API, we recommend the version 34.
3 Once you have your emulator, open the project. Now in the right side, you can find the emulator section and your previusly created emulator. You have to press in the start button and start the app.
To try the app in your own phone, you need to have the previous technologies and follow the next steps:
1 Put your phone on developer mode (Search your model and follow the steps to do it).
2 Activate the USB Depuration option
3 Activate "install via USB" (if your phone have this option)
4 Connect your phone to the PC.
5 Be sure that both dispositives are connected to the same Wi-Fi connection.
6 In visual studio code, open the project and navigate to the "Flask" directory, once here, you only need to put "python3 apps.py" in the terminal, after this, the Flask server should start automatically.
7 Navigate in the option (view) to the command palette, press in the option select device and select your phone.
8 If you have done all the neccessary steps(installing the tools and flutter doctor pass, press the key "F5"
Now a message like that should start:

Be careful looking at your phone, a confirmation screen of 10 seconds should appear to give permissions to install the app.
