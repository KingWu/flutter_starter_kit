# Flutter Starter Kit - App Store Example

A starter kit for beginner learns with Bloc pattern, RxDart, sqflite, Fluro and Dio to architect a flutter project. This starter kit build an App Store app as a example

![App Store Flutter Demo](https://i.ibb.co/FsyWhpY/ezgif-3-5dbb34baf658.gif)

## Feature
- Bloc Pattern
- Navigate pages by [Fluro](https://github.com/theyakka/fluro)
- Local cache by using [sqflite](https://github.com/tekartik/sqflite)
- Restful api call by using [Dio](https://github.com/flutterchina/dio)
- Database debugging (Android Only) by using [flutter_stetho](https://github.com/brianegan/flutter_stetho)
- Loading Network Image
- Localization by using Flutter i18n plugin
- Environment Variable & Project Config (Like App Name, Bundle Id) based on different project flavour (Development, Staging & Production)
- Build pojo by using json_serializable
- Update each list item instead of re-rendering whole list view when data set has changed on a list item
- Hero animation
- Show empty View when the list view is empty

## Install

1. Follow flutter [official setup guide](https://flutter.io/docs/get-started/install) to set up flutter environment
2. Install Flutter i18n plugin into Android Studio
    >Preference > Plugins > Browse repositories > Type ‘Flutter i18n’  > Install > Restart Android Studio

## Run Config
1. Click 'Edit Configuration'
2. Create different run configs for flavours

![Edit Config](https://i.ibb.co/sbkgnmN/Screen-Shot-2019-01-13-at-7-28-44-PM.png)

![Config](https://i.ibb.co/tqPgMVz/Screen-Shot-2019-01-13-at-7-52-38-PM.png)

![Flavour](https://i.ibb.co/hCP2QJ1/Screen-Shot-2019-01-13-at-7-40-16-PM.png)


## Useful Command
Generate json serialize and deserialize functions

> flutter packages pub run build_runner build --delete-conflicting-outputs

## Known Issues
- [Unable to launch app on ios simulator with different flavours](https://github.com/flutter/flutter/issues/21335)

## Migration Guide
- If you wanna to use this project as your project' base, please read [migration guide](https://github.com/KingWu/flutter_starter_kit/wiki/Migration-Guide)


## Reference

#### From other platform?
- [Flutter for Android developers](https://flutter.io/docs/get-started/flutter-for/android-devs)
- [Flutter for iOS developers](https://flutter.io/docs/get-started/flutter-for/ios-devs)
- [Flutter for React Native developers](https://flutter.io/docs/get-started/flutter-for/react-native-devs)
- [Flutter for web developers](https://flutter.io/docs/get-started/flutter-for/web-devs)
- [Flutter for Xamarin.Forms developers](https://flutter.io/docs/get-started/flutter-for/xamarin-forms-devs)

#### Learn Widget & Layout
- [Building Layouts](https://flutter.io/docs/development/ui/layout)
- [Widget catalog](https://flutter.io/docs/development/ui/widgets)
- [Series of flutter widget of the week](https://www.youtube.com/playlist?list=PLOU2XLYxmsIL0pH0zWe_ZOHgGhZ7UasUE)
- [Series of Flutter Widgets 101](https://www.youtube.com/playlist?list=PLOU2XLYxmsIJyiwUPCou_OVTpRIn_8UMd)


#### Bloc Pattern
- [Architect your Flutter project using BLOC pattern](https://medium.com/flutterpub/architecting-your-flutter-project-bd04e144a8f1)

#### Json Serialization
- [JSON and serialization](https://flutter.io/docs/development/data-and-backend/json)

#### Localization
- [Flutter: internationalization tutorials: Part 3— Android Studio plugin](https://medium.com/@datvt9312/flutter-internationalization-tutorials-part-3-android-studio-plugin-8604e2dc90f0)
- [讓 Flutter App 支援多國語系的開發流程](https://medium.com/@zonble/%E8%AE%93-flutter-app-%E6%94%AF%E6%8F%B4%E5%A4%9A%E5%9C%8B%E8%AA%9E%E7%B3%BB%E7%9A%84%E9%96%8B%E7%99%BC%E6%B5%81%E7%A8%8B-ceb31532e2e1)

#### Flavouring
- [Flavoring Flutter](https://medium.com/@salvatoregiordanoo/flavoring-flutter-392aaa875f36)
- [Creating flavors of a Flutter app (Flutter & Android setup)](http://cogitas.net/creating-flavors-of-a-flutter-app/)