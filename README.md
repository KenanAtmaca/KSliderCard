# KSliderCard

<p align="center">
<img src="https://user-images.githubusercontent.com/16580898/64905379-25667200-d6e0-11e9-9c3d-84cc4aed8b32.png" width="100%">
</p>

<br><p align="center">
<img src="https://user-images.githubusercontent.com/16580898/64905440-28ae2d80-d6e1-11e9-9456-eab7dd59832a.gif" width="35%"/>
<img src="https://user-images.githubusercontent.com/16580898/64905425-e258ce80-d6e0-11e9-9f0a-361179edf5e2.gif" width="35%"/>
</p>

## Requirements

- Xcode 9.0 +
- iOS 11.0 or greater

## Installation

### CocoaPods

1. Install [CocoaPods](http://cocoapods.org)
2. Add this repo to your `Podfile`

```ruby
platform :ios, '11.0'

target 'ProjectName' do
  use_frameworks!
  pod 'KSliderCard'
end
```

3. Run `pod install`
4. Open up the new `.xcworkspace` that CocoaPods generated
5. Whenever you want to use the library: `import KSliderCard`

### Manually

1. Simply download the `KSliderCard` source files and import them into your project.

## Usage

```Swift
import UIKit
import KSliderCard

class ViewController: UIViewController {
    
    var sliderCard:KSliderCard!

    override func viewDidLoad() {
        super.viewDidLoad()
        showSliderCard()
    }
    
    func showSliderCard() {
        sliderCard = KSliderCard(items: [KSliderCardItem(image: UIImage(named: "img1"), title: "Hello 🎉", text: "..."),
                                         KSliderCardItem(image: UIImage(named: "img2"), title: "Hii", text: "..."),
                                         KSliderCardItem(image: UIImage(named: "img3"), title: "Heey", text: "...")])
        sliderCard.options.isBlurImage = false
        sliderCard.options.backgroundStyle = .dark
        sliderCard.options.backAction = true
        sliderCard.options.backButtonImage = UIImage(named: "back")
        sliderCard.options.backButtonSize = CGSize(width: 64, height: 64)
        sliderCard.options.backButtonBackgroundColor = .clear
        sliderCard.options.backButtonColor = .white
        sliderCard.show(to: self.view)
    }
}

```

## License
Usage is provided under the [MIT License](http://http//opensource.org/licenses/mit-license.php). See LICENSE for the full details.
