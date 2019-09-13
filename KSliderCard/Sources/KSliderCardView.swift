//
//  Created by Kenan Atmaca on 11.09.2019.
//  Copyright © 2019 Kenan Atmaca. All rights reserved.
//

import UIKit

class KSliderCardView: UIView {
    
    private var contentView:UIView = {
       let view = UIView()
       view.layer.zPosition = 99
       view.backgroundColor = .black
       view.isUserInteractionEnabled = true
       view.layer.cornerRadius = 15
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()
    
    private var contentImageView: UIImageView = {
       let imgView = UIImageView()
       imgView.clipsToBounds = true
       imgView.layer.cornerRadius = 15
       imgView.contentMode = UIView.ContentMode.scaleAspectFill
       imgView.translatesAutoresizingMaskIntoConstraints = false
       return imgView
    }()
    
    private var titleLabel:UILabel = {
       let label = UILabel()
       label.numberOfLines = 0
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    private var subTitleTextView:UITextView = {
       let label = UITextView()
       label.backgroundColor = .clear
       label.isEditable = false
       label.isSelectable = false
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    private var backButton:UIButton = {
       let button = UIButton()
       button.layer.zPosition = 98
       button.layer.cornerRadius = 10
       button.translatesAutoresizingMaskIntoConstraints = false
       return button
    }()
    
    private var blurView:UIVisualEffectView!
    private var blurEffect:UIBlurEffect!
    private var labelsStack = UIStackView()
    private var panGesture:UIPanGestureRecognizer!
    
    private var contentWidth = NSLayoutConstraint()
    private var contentHeight = NSLayoutConstraint()
    private var contentBottom = NSLayoutConstraint()
    private var contentCenterY = NSLayoutConstraint()
    
    private var isToggleSize:Bool = false
    private var rotateDivisor:CGFloat = 0
    private var viewIndex:Int = 0
    
    var options = KSliderCardOptions()
    
    func setup(index: Int) -> UIView {
        self.viewIndex = index
        self.setupElementsUI()
        self.frame = UIScreen.main.bounds
        rotateDivisor = (self.frame.width / 2) / 0.61
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(panContentViewAction))
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapContentViewAction)))
        contentView.addGestureRecognizer(panGesture)
        self.addSubview(contentView)
        startOpenAnimation()
        
        contentWidth = contentView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.91)
        contentHeight = contentView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.55)
        contentWidth.isActive = true
        contentHeight.isActive = true
        contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        contentCenterY = contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0)
        contentCenterY.isActive = true
        contentBottom = contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        contentBottom.isActive = false
        
        contentView.addSubview(contentImageView)
        contentImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1.0).isActive = true
        contentImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1.0).isActive = true
        contentImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        contentImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        if options.isBlurImage {
            setupBlurView()
            blurView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
            blurView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
            blurView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
            blurView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        }
        
        contentView.addSubview(labelsStack)
        labelsStack.translatesAutoresizingMaskIntoConstraints = false
        labelsStack.alignment = .fill
        labelsStack.distribution = .fill
        labelsStack.axis = .vertical
        labelsStack.spacing = 10
        labelsStack.addArrangedSubview(titleLabel)
        labelsStack.addArrangedSubview(subTitleTextView)
        
        labelsStack.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 30).isActive = true
        labelsStack.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10).isActive = true
        labelsStack.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10).isActive = true
        labelsStack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
        
        if options.backAction {
            self.addSubview(backButton)
            backButton.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 20).isActive = true
            backButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
            backButton.widthAnchor.constraint(equalToConstant: options.backButtonSize?.width ?? 100).isActive = true
            backButton.heightAnchor.constraint(equalToConstant: options.backButtonSize?.height ?? 40).isActive = true
        }
        
        return self
    }
    
    private func setupElementsUI() {
        if options.items.count > 0 {
            contentImageView.image = options.items[viewIndex].image
            titleLabel.text = options.items[viewIndex].title
            subTitleTextView.text = options.items[viewIndex].subTitle
        }
        titleLabel.font = options.titleFont ?? UIFont(name: "Futura-Bold", size: 30)
        subTitleTextView.font = options.subTitleFont ?? UIFont(name: "Avenir-Medium", size: 17)
        titleLabel.textColor = options.titleColor ?? .white
        subTitleTextView.textColor = options.subTitleColor ?? .white
        backButton.addTarget(self, action: #selector(tapBackButtonAction), for: .touchUpInside)
        backButton.titleLabel?.font = options.backButtonFont ?? UIFont(name: "Avenir-Medium", size: 17)
        backButton.setTitle(options.backButtonTitle ?? "BACK", for: .normal)
        backButton.setImage(options.backButtonImage, for: .normal)
        backButton.setTitleColor(options.backButtonTextColor ?? .white, for: .normal)
        backButton.backgroundColor = options.backButtonBackgroundColor ?? UIColor.gray
        backButton.tintColor = options.backButtonColor
    }
    
    private func startOpenAnimation() {
        guard options.isAnimation else { return }
        contentView.alpha = 0
        contentView.transform = CGAffineTransform.init(scaleX: 0.3, y: 0.3)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
            self.contentView.alpha = 1
            self.contentView.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    private func setupBlurView() {
        if let blurStyle = options.blurStyle {
            switch (blurStyle) {
            case .dark: blurEffect = UIBlurEffect(style: .dark)
            case .light: blurEffect = UIBlurEffect(style: .light)
            case .none: blurEffect = UIBlurEffect(style: .dark)
            }
        } else {
            blurEffect = UIBlurEffect(style: .dark)
        }
        blurView = UIVisualEffectView(effect: blurEffect)
        blurView.isUserInteractionEnabled = true
        blurView.clipsToBounds = true
        blurView.layer.cornerRadius = 15
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(blurView)
    }
    
    @objc private func panContentViewAction(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        let percent = translation.x / self.bounds.size.width
        let xFromCenter = contentView.center.x - self.center.x
        let alphaPercent = 1 - abs(xFromCenter * 0.01) / 5
        
        self.contentView.center = CGPoint(x: self.center.x + translation.x, y: self.center.y + translation.y)
        self.contentView.transform = CGAffineTransform.init(rotationAngle: xFromCenter / rotateDivisor)
        if alphaPercent >= 0.7 { self.contentView.alpha = alphaPercent }
        
        if gesture.state == .ended {
            if abs(percent) >= 0.51 { removeCard() }
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {
                self.contentView.center = self.center
                self.contentView.transform = CGAffineTransform.identity
                self.contentView.alpha = 1
            }, completion: nil)
        }
    }
    
    private func removeCard() {
        guard self.options.cardsStack.indices.contains(self.viewIndex) else { return }
        let cardView = self.options.cardsStack[self.viewIndex]
        self.removeFromSuperview()
        if options.cardsStack.count > 1 {
            if options.isAnimation {
                UIView.animate(withDuration: 0.5, animations: {
                    cardView.transform = CGAffineTransform.init(scaleX: 1.01, y: 1.01)
                }) { (_) in
                    UIView.animate(withDuration: 0.5, animations: {
                        cardView.transform = CGAffineTransform.identity
                    })
                }
            }
            self.options.cardsStack.remove(at: self.viewIndex)
        } else {
            self.options.cardsStack.remove(at: self.viewIndex)
            NotificationCenter.default.post(name: Notification.Name.removeBackground, object: nil)
        }
    }
    
    @objc private func tapContentViewAction() {
        isToggleSize.toggle()
        if isToggleSize {
            self.panGesture.isEnabled = false
            self.contentWidth.isActive = false
            self.contentHeight.isActive = false
            self.contentCenterY.isActive = false
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [.curveEaseIn], animations: {
                self.contentWidth = self.contentView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1)
                self.contentHeight = self.contentView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.95)
                self.contentWidth.isActive = true
                self.contentHeight.isActive = true
                self.contentBottom.isActive = true
                if self.options.isBlurImage { self.blurView.layer.cornerRadius = 0 }
                self.layoutIfNeeded()
            }, completion: nil)
        } else {
            self.panGesture.isEnabled = true
            self.contentWidth.isActive = false
            self.contentHeight.isActive = false
            self.contentBottom.isActive = false
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [.curveEaseOut], animations: {
                self.contentWidth = self.contentView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.91)
                self.contentHeight = self.contentView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.55)
                self.contentWidth.isActive = true
                self.contentHeight.isActive = true
                self.contentCenterY.isActive = true
                if self.options.isBlurImage { self.blurView.layer.cornerRadius = 15 }
                self.layoutIfNeeded()
            }) { (_) in
                self.subTitleTextView.setContentOffset(.zero, animated: false)
            }
        }
    }
    
    @objc private func tapBackButtonAction() {
        NotificationCenter.default.post(name: .backCard, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
