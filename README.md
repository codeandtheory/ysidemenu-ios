![Y—SideMenu](https://user-images.githubusercontent.com/1037520/232458793-f0765475-5100-48ad-9d8c-af2e9b53bd5d.jpeg)
_Accessible and customizable side menu for iOS._

Licensing
----------
Y—SideMenu is licensed under the [Apache 2.0 license](LICENSE).

Documentation
----------

Documentation is automatically generated from source code comments and rendered as a static website hosted via GitHub Pages at: https://yml-org.github.io/ysidemenu-ios/

Usage
----------

To use `YSideMenu` in your app, you need to create an instance of `SideMenuController`, passing a child view controller as a parameter. Here is an example of how to create and present a side menu:
```swift
import YSideMenu

let sideMenuController = SideMenuController(rootViewController: contentViewController)
present(sideMenuController, animated: true, completion: nil)
```

### Customization
`SideMenuController` has an `appearance` property of type `Appearance`.

`Appearance` lets you customize how the bosi menu both appears and behaves. You can customize:

```swift
let contentViewController = ContentViewController()
let sideMenuController = SideMenuController(rootViewController: menuViewController)
sideMenuController.appearance = .init(
    dimmerColor: UIColor.black.withAlphaComponent(0.5),
    idealWidthPercentage: 0.75,
    maximumWidth: 300,
    isDismissAllowed: true
)
```

```swift
appearance.presentAnimation = Animation(
    duration: 0.4, 
    curve: .spring(damping: 0.6, velocity: 0.4)
)

// Present the menu with a spring animation.
present(sheet, animated: true)
```

You can customize the appearance of the side menu by setting the `appearance` property of the `SideMenuController`. The `Appearance` struct contains the following properties:

`dimmerColor`: the color of the dimmer view that is displayed behind the side menu (default is black with an alpha of 0.3).
`idealWidthPercentage`: the ideal width of the side menu as a percentage of the width of the screen (default is 0.75).
`maximumWidth`: the maximum width of the side menu in points (default is 300).
`isDismissAllowed`: a Boolean value that indicates whether the user can dismiss the side menu by tapping outside of it or by swiping it to the left (default is true).
`presentAnimation`: present animation 
`dismissAnimation`: dismiss animation

Dependencies
----------

Y—SideMenu depends upon our [Y—CoreUI](https://github.com/yml-org/ycoreui)framework (which is also open source and Apache 2.0 licensed).

Installation
----------

You can add Y—SideMenu to an Xcode project by adding it as a package dependency.

1. From the **File** menu, select **Add Packages...**
2. Enter "[https://github.com/yml-org/ysidemenu-ios](https://github.com/yml-org/ysidemenu-ios)" into the package repository URL text field
3. Click **Add Package**

Contributing to Y—SideMenu
----------

### Requirements

#### SwiftLint (linter)
```
brew install swiftlint
```

#### Jazzy (documentation)
```
sudo gem install jazzy
```

### Setup

Clone the repo and open `Package.swift` in Xcode.

### Versioning strategy

We utilize [semantic versioning](https://semver.org).

```
{major}.{minor}.{patch}
```

e.g.

```
1.0.5
```

### Branching strategy

We utilize a simplified branching strategy for our frameworks.

* main (and development) branch is `main`
* both feature (and bugfix) branches branch off of `main`
* feature (and bugfix) branches are merged back into `main` as they are completed and approved.
* `main` gets tagged with an updated version # for each release
 
### Branch naming conventions:

```
feature/{ticket-number}-{short-description}
bugfix/{ticket-number}-{short-description}
```
e.g.
```
feature/CM-44-button
bugfix/CM-236-textview-color
```

### Pull Requests

Prior to submitting a pull request you should:

1. Compile and ensure there are no warnings and no errors.
2. Run all unit tests and confirm that everything passes.
3. Check unit test coverage and confirm that all new / modified code is fully covered.
4. Run `swiftlint` from the command line and confirm that there are no violations.
5. Run `jazzy` from the command line and confirm that you have 100% documentation coverage.
6. Consider using `git rebase -i HEAD~{commit-count}` to squash your last {commit-count} commits together into functional chunks.
7. If HEAD of the parent branch (typically `main`) has been updated since you created your branch, use `git rebase main` to rebase your branch.
    * _Never_ merge the parent branch into your branch.
    * _Always_ rebase your branch off of the parent branch.

When submitting a pull request:

* Use the [provided pull request template](.github/pull_request_template.md) and populate the Introduction, Purpose, and Scope fields at a minimum.
* If you're submitting before and after screenshots, movies, or GIF's, enter them in a two-column table so that they can be viewed side-by-side.

When merging a pull request:

* Make sure the branch is rebased (not merged) off of the latest HEAD from the parent branch. This keeps our git history easy to read and understand.
* Make sure the branch is deleted upon merge (should be automatic).

### Releasing new versions
* Tag the corresponding commit with the new version (e.g. `1.0.5`)
* Push the local tag to remote

Generating Documentation (via Jazzy)
----------

You can generate your own local set of documentation directly from the source code using the following command from Terminal:
```
jazzy
```
This generates a set of documentation under `/docs`. The default configuration is set in the default config file `.jazzy.yaml` file.

To view additional documentation options type:
```
jazzy --help
```
A GitHub Action automatically runs each time a commit is pushed to `main` that runs Jazzy to generate the documentation for our GitHub page at: https://yml-org.github.io/ysidemenu-ios/
