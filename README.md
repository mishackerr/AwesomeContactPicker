# AwesomeContactPicker

[![CI Status](https://img.shields.io/travis/MichaelGuoXY/AwesomeContactPicker.svg?style=flat)](https://travis-ci.org/MichaelGuoXY/AwesomeContactPicker)
[![Version](https://img.shields.io/cocoapods/v/AwesomeContactPicker.svg?style=flat)](https://cocoapods.org/pods/AwesomeContactPicker)
[![License](https://img.shields.io/cocoapods/l/AwesomeContactPicker.svg?style=flat)](https://cocoapods.org/pods/AwesomeContactPicker)
[![Platform](https://img.shields.io/cocoapods/p/AwesomeContactPicker.svg?style=flat)](https://cocoapods.org/pods/AwesomeContactPicker)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

iOS: 11.0

## Installation

AwesomeContactPicker is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'AwesomeContactPicker'
```

## Usage

### Display the contact UI by calling the following method:

```swift
AwesomeContactPicker.shared.openContacts(with: YourViewController, delegate: YourDelegateObject)
```

![Display Contacts](https://github.com/MichaelGuoXY/AwesomeContactPicker/blob/master/Screenshots/display.png)

### Select/deselect contacts by tapping them:

![Select Contacts](https://github.com/MichaelGuoXY/AwesomeContactPicker/blob/master/Screenshots/select.png)

### Search contacts by typing in the search box

![Search Contacts](https://github.com/MichaelGuoXY/AwesomeContactPicker/blob/master/Screenshots/search.png)

### Configure UI

```swift
// Pre select contacts
AwesomeContactSettings.preSelectedContacts = ["contact1", "contact2"]

// Nav bar
AwesomeContactSettings.navBarBarTintColor = .orange
AwesomeContactSettings.navBarTintColor = .purple
AwesomeContactSettings.navBarTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

// Section index
AwesomeContactSettings.sectionIndexHidden = false
AwesomeContactSettings.sectionIndexColor = .white
```

### Delegate

Let YourViewController conforms to `AwesomeContactPickerProtocol`:

```swift
extension ViewController: AwesomeContactPickerProtocol {
    func didDismiss(with type: AwesomeContactPicker.DismissType, contacts: Set<String>?) {
        switch type {
        case .done:
            // Do something with the contacts
        default:
            break
        }
    }
}
```

## Author

Michael Guo, xg229@cornell.edu

## License

AwesomeContactPicker is available under the MIT license. See the LICENSE file for more info.
