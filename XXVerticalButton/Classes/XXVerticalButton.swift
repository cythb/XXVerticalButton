//
//  XXVerticalButton.swift
//  XXVerticalButton
//
//  Created by Masher Shin on 2/15/17.
//  Copyright © 2017 Masher Shin. All rights reserved.
//

import UIKit

@IBDesignable
open class XXVerticalButton: UIButton {
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setNeedsUpdateConstraints()
    }
    
    @IBInspectable
    open var verticallyAlign: Bool = false
    
    @IBInspectable
    open var verticallySpacing: CGFloat = 0
    
    @IBInspectable
    open var verticallyPoint: CGPoint = CGPoint(x: 0, y: 0)
    
    @IBInspectable
    open var secondaryImage: UIImage?
    
    @IBInspectable
    open var secondaryHighlightedImage: UIImage?
    
    private func configureVertically() {
        guard verticallyAlign else { return }
        
        self.clipsToBounds = true
        
        if let secondaryImage = isHighlighted ? secondaryHighlightedImage : secondaryImage {
            let secondaryImageSize = secondaryImage.size
            
            imageEdgeInsets = UIEdgeInsets(top: -(secondaryImageSize.height + verticallySpacing) - verticallyPoint.y,
                                           left: -verticallyPoint.x,
                                           bottom: verticallySpacing + verticallyPoint.y,
                                           right: verticallyPoint.x)
            
            secondaryImage.draw(at: CGPoint(x: bounds.width / 2 - secondaryImageSize.width / 2 + verticallyPoint.x,
                                            y: bounds.height / 2 + verticallySpacing + verticallyPoint.y))
            
        } else {
            let imageSize = imageView?.frame.size ?? CGSize(width: 0, height: 0)
            
            let titleSize = titleLabel?.frame.size ?? CGSize(width: 0, height: 0)
            
            var offsetX = (intrinsicContentSize.width - imageSize.width)/2
            if offsetX > 3.5 {
                offsetX -= 3.5
            }
            imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + verticallySpacing) - verticallyPoint.y,
                                           left: offsetX - verticallyPoint.x,
                                           bottom: 0 + verticallyPoint.y,
                                           right: -offsetX + verticallyPoint.x)
            
            titleEdgeInsets = UIEdgeInsets(top: 0 - verticallyPoint.y,
                                           left: -imageSize.width - verticallyPoint.x,
                                           bottom: -(imageSize.height + verticallySpacing) + verticallyPoint.y,
                                           right: 0 + verticallyPoint.x)
        }
    }
    
    override open func draw(_ rect: CGRect) {
        configureVertically()
        invalidateIntrinsicContentSize()
        
        // remove constrains of lable with image
        if let cs = self.imageView?.superview?.constraints {
            let imageContraints = cs.filter({ (constraint) -> Bool in
                return (constraint.firstItem as? NSObject == self.imageView || constraint.secondItem as? NSObject == self.imageView) && (constraint.firstAttribute == .left || constraint.firstAttribute == .right)
            })
            let removeContraints = imageContraints.filter({ (constraint) -> Bool in
                return constraint.relation == NSLayoutRelation.equal;
            })
            for c in removeContraints {
                c.isActive = false
            }
        }
        
        super.draw(rect)
    }
    
    override open var intrinsicContentSize: CGSize {
        let originSize = super.intrinsicContentSize
        let imageSize = imageView?.image?.size ?? CGSize(width: 0, height: 0)
        // Fix: title not display normally in XIB
        titleLabel?.sizeToFit()
        let titleSize = titleLabel?.frame.size ?? CGSize(width: 0, height: 0)
        let size = CGSize(width: max(imageSize.width, titleSize.width) + 7,
                      height: imageSize.height + titleSize.height + verticallySpacing + 12) // 12 = top margin + bottom margin
        
        if originSize.width >= size.width && originSize.height >= size.height {
            return originSize
        } else {
            return size
        }
    }

    open override func updateConstraints() {
        guard verticallyAlign else { return super.updateConstraints()}
        guard (secondaryImage == nil) else { return super.updateConstraints()}
        
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        if let imageView = self.imageView {
            let imageConstraintCenterX = NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: imageView.superview, attribute: .centerX, multiplier: 1.0, constant: 0)
            imageView.superview?.addConstraint(imageConstraintCenterX)
        }
        
        if let titleLabel = self.titleLabel {
            titleLabel.textAlignment = .center
            let imageConstraintCenterX = NSLayoutConstraint(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: titleLabel.superview, attribute: .centerX, multiplier: 1.0, constant: 0)
            titleLabel.superview?.addConstraint(imageConstraintCenterX)
        }
        super.updateConstraints()
    }
}
