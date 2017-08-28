# JPSwitchButton

[![CI Status](http://img.shields.io/travis/julp04/JPSwitchButton.svg?style=flat)](https://travis-ci.org/julp04/JPSwitchButton)
[![Version](https://img.shields.io/cocoapods/v/JPSwitchButton.svg?style=flat)](http://cocoapods.org/pods/JPSwitchButton)
[![License](https://img.shields.io/cocoapods/l/JPSwitchButton.svg?style=flat)](http://cocoapods.org/pods/JPSwitchButton)
[![Platform](https://img.shields.io/cocoapods/p/JPSwitchButton.svg?style=flat)](http://cocoapods.org/pods/JPSwitchButton)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

JPSwitchButton is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "JPSwitchButton"
```


# Usage

## Initalizing Button

### Button Without an Image
```swift
let switchButton = JPSwitchButton(frame: buttonFrame, offColor: .white, onColor: blue, image: nil, title: "Press me to turn on", description: "Currently I am off", isOn: false)
```

![Alt text](https://github.com/Julp04/JPSwitchButton/blob/master/jpswitchbutton_0.gif)

### Button With an Image

```swift
let twitterButton = JPSwitchButton(frame: buttonFrame2, offColor: .white, onColor: twitterBlue, image: #imageLiteral(resourceName: "twitter_on"), title: "Connect with Twitter", description: "Add your twitter account!")
```

![Alt text](https://github.com/Julp04/JPSwitchButton/blob/master/jpswitchbutton_2.gif)

### On Button Click
You can choose what happens when your button is clicked by writing your code inside the block
```swift
switchButton.onClick =  {

          switchButton.switchState()
          switchButton.buttonTitle = switchButton.isOn ? "Press me to turn off" : "Press me to turn on"
          switchButton.buttonDescription = switchButton.isOn ? "Currently I am on" : "Currently I am off"
}
```

### On long press
Create different action for a long press
```swift
twitterButton.onLongPress =  {
        if twitterButton.isOn {
            let url = URL(string: "http://twitter.com/\(username)")!
            UIApplication.shared.openURL(url)
        }
    }
```

![Alt text](https://github.com/Julp04/JPSwitchButton/blob/master/jpswitchbutton_3.gif)

## Changing Button State

### Switch State
Will turn it off if on, and vice versa
```swift
switchButton.onClick =  {
         switchButton.switchState()
}
```

### Turn On
```swift
switchButton.onClick =  {
         switchButton.turnOn()
}
```

### Turn Off
```swift
switchButton.onClick =  {
         switchButton.turnOff()
}
```

## Author

julp04, julpanucci@gmail.com

## License

JPSwitchButton is available under the MIT license. See the LICENSE file for more info.
