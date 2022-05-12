# flutter_sample_geolocator_plugin

A Flutter project using the Geolocator plugin.

![image](https://user-images.githubusercontent.com/20613997/166651897-fb1e158f-e9c3-45df-9411-3c93ef965540.png)

## Getting Started

This app displays the heading, speed, and altitude of the device using GeoLocator.getPositionStream().

- [GeoLocator plugin](https://pub.dev/packages/geolocator)
- [GeoLocator.getPositionStream](https://pub.dev/documentation/geolocator/latest/geolocator/Geolocator/getPositionStream.html)
- [GeoLocator's Position class](https://pub.dev/documentation/geolocator_platform_interface/latest/geolocator_platform_interface/Position-class.html)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Using the Geolocator plugin
1. Installing the plugin
```
  flutter pub add geolocator
  flutter pub get
```
Run these commands in the terminal or Command Prompt for Windows. Make sure that you are in the project directory.

2. Plaform specific setup
    1. Android
        1. Add the following to your "gradle.properties" file:
        ```
        android.useAndroidX=true
        android.enableJetifier=true
        ```
        2. Make sure you set the `compileSdkVersion` in your "android/app/build.gradle" file to 31:
        ```
        android.useAndroidX=true
        android.enableJetifier=true
        ```
        3. Add location permissions to your AndroidManifest.xml (located under android/app/src/main)
        ```
        <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
        <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
        ```
        Read [this](https://developer.android.com/guide/topics/manifest/manifest-intro) for more details on adding permissions in the manifest file.
    2. iOS
        1. Add the following entries to your Info.plist file (located under ios/Runner)
        ```
        <key>NSLocationWhenInUseUsageDescription</key>
        <string>This app needs access to location when open.</string>
        <key>NSLocationAlwaysUsageDescription</key>
        <string>This app needs access to location when in the background.</string>
        ```

At this point your project is now ready to make use of the Geolocator plugin. 👍👍

Here are some snippets ✂️
---
### Checking and asking for permissions. ✅
```
Geolocator.checkPermission().then((permission) {
  if (permission == LocationPermission.denied) {
    Geolocator.requestPermission().then((requestPermission) {
      if (requestPermission == LocationPermission.denied ||
          requestPermission == LocationPermission.deniedForever) {
        var errorSnackBar = const SnackBar(content: Text('Denied of required permissions'));
        ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
      }
    });
  }
});
```
### Get updates when location changes. 🎢
```
StreamSubscription<Position> positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen(
  (Position? position) {
      print(position == null ? 'Unknown' : '${position.latitude.toString()}, ${position.longitude.toString()}');
});
// listen to positionStream or put it in a StreamBuilder
```
