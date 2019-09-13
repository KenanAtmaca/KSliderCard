//
//  Created by Kenan Atmaca on 11.09.2019.
//  Copyright © 2019 Kenan Atmaca. All rights reserved.
//

import UIKit

open class KSliderCard {
    
    private var backgroundView = KSliderCardBackgroundView()
    private var tmpCards:[KSliderCardView] = []
    private var rootView:UIView!
    
    public var options = KSliderCardOptions()
    
    public init() {
        setupObservers()
    }
    
    public func show(to view: UIView) {
        self.rootView = view
        backgroundView.style = options.backgroundStyle
        view.addSubview(backgroundView.setup())
        options.items = options.items.reversed()
        
        if options.items.count > 1 {
            (0..<options.items.count).forEach { (index) in
                let item = KSliderCardView()
                item.options = options
                options.cardsStack.append(item)
                view.addSubview(item.setup(index: index))
            }
            tmpCards = options.cardsStack
        } else {
           let singleItem = KSliderCardView()
           singleItem.options = options
           options.cardsStack.append(singleItem)
           view.addSubview(singleItem.setup(index: 0))
        }
    }
    
    @objc private func removeBackground() {
        backgroundView.remove()
    }
    
    @objc private func backCard() {
        if options.cardsStack.count != tmpCards.count {
            options.cardsStack.append(tmpCards[options.cardsStack.count])
            if let lastView = options.cardsStack.last {
                rootView.addSubview(lastView)
                lastView.alpha = 0
                UIView.animate(withDuration: 0.5) {
                    lastView.alpha = 1
                }
            }
        }
    }
    
    public func remove() {
        rootView.subviews.forEach { (subView) in
            if subView is KSliderCardView {
               subView.removeFromSuperview()
            }
        }
        removeBackground()
    }
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(removeBackground), name: .removeBackground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(backCard), name: .backCard, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
