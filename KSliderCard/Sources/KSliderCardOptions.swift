//
//  Created by Kenan Atmaca on 11.09.2019.
//  Copyright © 2019 Kenan Atmaca. All rights reserved.
//

import UIKit

public enum KSliderBackgroundStyle {
    case dark
    case light
    case none
}

public class KSliderCardOptions {
    
    var cardsStack:[KSliderCardView] = []
    public var items:[KSliderCardItem] = []
    
    public var titleColor:UIColor?
    public var subTitleColor:UIColor?
    public var titleFont:UIFont?
    public var subTitleFont:UIFont?
    public var isBlurImage:Bool = true
    public var isAnimation:Bool = true
    public var backgroundStyle:KSliderBackgroundStyle?
    public var blurStyle:KSliderBackgroundStyle?
    public var backAction:Bool = false
    public var backButtonTitle:String?
    public var backButtonImage:UIImage?
    public var backButtonBackgroundColor:UIColor?
    public var backButtonColor:UIColor?
    public var backButtonTextColor:UIColor?
    public var backButtonFont:UIFont?
    public var backButtonSize:CGSize?
}
