[![license](https://img.shields.io/github/license/maximkhatskevich/TrafficLights.svg)](https://opensource.org/licenses/MIT)
![Platforms](https://img.shields.io/badge/platforms-ios-lightgrey.svg)
[![GitHub tag](https://img.shields.io/github/tag/maximkhatskevich/TrafficLights.svg)](https://github.com/maximkhatskevich/TrafficLights/releases)
![Swift version](https://img.shields.io/badge/swift-3-orange.svg)

# Introduction

A single-view iOS app that simulates a set of traffic lights at an intersection.

# Requirements

## Layout

The traffic lights should be arranged North-South and East-West like a compass. And there should be a button to start/stop the animation.

## Logic

When switching from green to red, the yellow light must be displayed for 5 seconds prior to it switching to red. The lights will change automatically every 30 seconds.

## Other

The app should be written using Swift 3. Any external libraries should be included in the project directly.

# Approach

[ProjectGenerator](https://xcessentials.github.io/ProjectGenerator/) and [Struct](https://github.com/workshop/struct) are used to manage Xcode project file, that makes it easy to merge conflicting changes on project settings and/or new/renamed files in the project. [Carthage](https://github.com/Carthage/Carthage) is being used to install 'ProjectGenerator' source files into the project.

[Fastlane](https://fastlane.tools) is being used for routine tasks automation, such as generate/regenerate project file and increment project version/build number.

[CocoaPods](https://cocoapods.org) helps managing dependencies, all dependencies are stored in the repo, so the app codebase is ready to build and run out of the box.

[R.swift](https://github.com/mac-cain13/R.swift) is used to improve development experience and eliminate errors when working with resources.

To see the source code - open the **TrafficLights.xcworkspace** file.

The app is built using the "unidirectional data flow" and "finite state machine" design patterns.

High level app architecture is implemented using [UniFlow](http://xcessentials.github.io/UniFlow/) framework. See [introduction](https://github.com/XCEssentials/UniFlow#pre-existing-solutions), [theoretical fundamentals](https://github.com/XCEssentials/UniFlow#theoretical-fundamentals)
and [methodology overview](https://github.com/XCEssentials/UniFlow#methodology-overview) to better understand how app data model and business logic are organized.

All source files are grouped into 2 big groups - **Model** (that represents data model and business logic) and **View** (that implements presentation logic and is responsigle for passing user input to the *Model* layer). The *View* types rely on *Model* types, while *Model* types know nothing about *View*.

All *Model* files start with `M.` prefix, while all *View* - with `V.` prefix. `AppDelegate.swift` file supposed to be part of `V.Delegate` file inside `View` folder/group, but kept with traditional name and at the top level to help developers who are unfamiliar with such naming conventions to find initial entry point faster.

The `Preview.storyboard` is not included in the app bundle, because it's only needed for developer convenience to preview views during development in real time without running the app. To make it work, the `V_Root_View` class is named this way and is not nested (ti is supposed to be nested inside `V.Root` type and have ful name like this: `V.Root.View`) due to limitations of IB Storyboards - nested types are not supported for view custom class on storyboards.

To give the code better structure, Swift "nested type" feature is widely used. If a type is not supposed to be ever instantiated, it's declared as enum without any single case. Outer type works as scope for nested types.

[MKHState](https://github.com/maximkhatskevich/MKHState) framework is used to manage GUI states (*View* classes).
