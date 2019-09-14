//
//  Created by Kenan Atmaca on 11.09.2019.
//  Copyright © 2019 Kenan Atmaca. All rights reserved.
//

import UIKit

open class KSliderCard {
    
    private var backgroundView = KSliderCardBackgroundView()
    private var tmpCards:[KSliderCardView] = []
    private var data = KSliderCardDataProvider()
    private var rootView:UIView!
    
    public var options = KSliderCardOptions()
    
    public init() {
        setupObservers()
    }
    
    public convenience init (items: [KSliderCardItem]) {
        self.init()
        data.items = items
    }
    
    public func show(to view: UIView) {
        self.rootView = view
        backgroundView.style = options.backgroundStyle
        view.addSubview(backgroundView.setup())
        data.items = data.items.reversed()
        
        if data.items.count > 1 {
            (0..<data.items.count).forEach { (index) in
                let item = KSliderCardView()
                item.options = options
                item.data = data
                data.cardsStack.append(item)
                view.addSubview(item.setup(index: index))
            }
            tmpCards = data.cardsStack
        } else {
           let singleItem = KSliderCardView()
           singleItem.options = options
           singleItem.data = data
           data.cardsStack.append(singleItem)
           view.addSubview(singleItem.setup(index: 0))
        }
    }
    
    @objc private func removeBackground() {
        backgroundView.remove()
    }
    
    @objc private func backCard() {
        if data.cardsStack.count != tmpCards.count {
            data.cardsStack.append(tmpCards[data.cardsStack.count])
            if let lastView = data.cardsStack.last {
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
