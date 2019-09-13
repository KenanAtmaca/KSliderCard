//
//  Created by Kenan Atmaca on 11.09.2019.
//  Copyright © 2019 Kenan Atmaca. All rights reserved.
//

import UIKit

class KSliderCardBackgroundView: UIView {
    
    var style:KSliderBackgroundStyle?

    func setup() -> UIView {
        self.frame = UIScreen.main.bounds
        if let backgroundStyle = style {
            switch (backgroundStyle) {
            case .dark: self.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            case .light: self.backgroundColor = UIColor.white.withAlphaComponent(0.3)
            case .none: self.removeFromSuperview()
            }
        } else {
            self.backgroundColor = .clear
        }
        return self
    }
    
    func remove() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { (_) in
            self.removeFromSuperview()
        }
    }
}
