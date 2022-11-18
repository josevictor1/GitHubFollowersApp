# GitHubFollowersApp

![CI](https://github.com/josevictor1/GitHubFollowersApp/workflows/CI/badge.svg?branch=master)
[![codecov](https://codecov.io/gh/josevictor1/GitHubFollowersApp/branch/master/graph/badge.svg?token=1YWBT2WND9)](https://codecov.io/gh/josevictor1/GitHubFollowersApp)

## Demo 

<img src="https://user-images.githubusercontent.com/10730536/156906358-476c5abb-95c9-4e65-bd8d-6615c2e1b10e.png" height= "300"> | <img src="https://user-images.githubusercontent.com/10730536/156906370-af79217c-25ec-41e4-86bb-4e98a53a788d.png" height= "300"> | <img src="https://user-images.githubusercontent.com/10730536/156906898-2292ad79-4787-4339-b792-16eda5fade15.png" height= "300"> | <img src="https://user-images.githubusercontent.com/10730536/156907108-16704045-c935-4634-8ffd-e5ef83a5870b.png" height= "300"> | <img src="https://user-images.githubusercontent.com/10730536/156907282-32250eac-2ca0-4bb1-82ea-d9c27287de6a.gif" height= "300">
 --- | --- | --- | --- | ---

## Description 🗒

The GitHubFollowersApp is a portfolio based on the [GitHub API](https://docs.github.com/en/rest/reference/users).

## Architecture 📐

The architecture was based on [MVC(Model-View-Controller)](https://developer.apple.com/library/archive/documentation/General/Conceptual/DevPedia-CocoaCore/MVC.html) that provides a separation of concerns between the existing layers. This particular implementation adds more elements on the **Controller** layer, creating an additional element **LogicController**, that is responsible to control all the business logic and the communication with the **Model** layer.

To manage the routing a **Coordinator** was added to each module where every scene accessed the coordinator to navigate in the flow. This way the navigation logic was moved from **ViewController** to the **Coordinator**.

These changes resulted in a more concise **ViewController** implementation, reducing its responsibility to control the controller and format data to implementation.

The image bellow ilustrates tbe implementation:

<img src="https://user-images.githubusercontent.com/10730536/156907694-043bb733-beb7-4095-9770-7fd5bbe400ed.png" height= "300">

This architectural changes on MVC were based on three articles:
 - [Controllers in Swift](https://swiftbysundell.com/clips/5/)
 - [Logic controllers in Swift](https://www.swiftbysundell.com/articles/logic-controllers-in-swift/)
 - [MVC: Many View Controllers](https://www.rambo.codes/posts/2020-02-20-mvc-with-sugar)

## Modules 📦

The modules were created to separate reusable aiming to be used as libraries in another project and also to improve the isolation of each feature allowing new features to be built and added as libraries and handling these features as small apps.

The app is composed of 10 modules (Frameworks) grouped by folders accordingly to the usage:

- App: The folder that contains only the main module.
    - GitHub: The main project module that groups the usage of all other modules.
- Features: The folder that contains all feature modules in the app.
    - FavoriteProfiles: The feature that shows up the favorited profiles.
    - GetFollowers: The App first screen, where the user enters with the GitHub username and show up all its followers.
    - UserInformation: The feature that shows up the GitHub information for a specific user.
- In-House Frameworks: Contains frameworks that are used as tools in the app.
    - ImageDownloader: Responsible to download and caching images.
    - Networking: As the name says is that module that provides an interface with the URL session.
    - UIComponents: Centralize all custom reusable components.
    - Core: This contains the central and the common code used by all the modules.
    - Commons: Centralize common code tools used in the app.
- Services: Layer that holds that communication interface between app and service.
    - Data Store: Responsible to cache long-term data.
    - GitHub services: Centralize the service interfaces used in the app by one or more screens.  

The image bellow illustrates it:

<img src="https://user-images.githubusercontent.com/10730536/156928569-103a1f72-baa7-4bc7-9ed7-b14c718208de.png" height= "600">

## Stack 📚

- Swift 5
- UIKit
- Core Data
- Modularization
- NSCache
- Diffable DataSource
- Dynamic Type
- System Theme
- Unit Tests

## Minimum Requirements 💻

- Xcode 14

## How to run it 📲

- This project doesn’t contain any particularity. You can open the **GitHub.xcworkspace**, tap on the play button, or type **command+R**. 

## How to use it 🧐

The app is really simple to use once it works as a gallery. To see the items in the galley you can select a github profile.
