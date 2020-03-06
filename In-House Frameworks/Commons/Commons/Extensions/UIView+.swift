//
//  UIView+.swift
//  Commons
//
//  Created by José Victor Pereira Costa on 01/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit

public extension UIView {
    
    ///Creates a constraints to any side of the view
    /// - Parameters:
    ///   - top: The top anchor anchor from a __UIView__ object
    ///   - left: The left anchor anchor from a __UIView__ object
    ///   - bottom: The bottom anchor anchor from a __UIView__ object
    ///   - right: The right anchor anchor from a __UIView__ object
    ///   - topConstant: Top anchor constant offset for the constraint
    ///   - leftConstant: Left anchor constant offset for the constraint
    ///   - bottomConstant: Bottom anchor constant offset for the constraint
    ///   - rightConstant: Right anchor constant offset for the constraint
    ///   - widthConstant: Width anchor constant offset for the constraint
    ///   - heightConstant: Height anchor constant offset for the constraint
    @discardableResult func constraint(top: NSLayoutYAxisAnchor? = nil,
                                              left: NSLayoutXAxisAnchor? = nil,
                                              bottom: NSLayoutYAxisAnchor? = nil,
                                              right: NSLayoutXAxisAnchor? = nil,
                                              topConstant: CGFloat = 0,
                                              leftConstant: CGFloat = 0,
                                              bottomConstant: CGFloat = 0,
                                              rightConstant: CGFloat = 0,
                                              widthConstant: CGFloat = 0,
                                              heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: bottomConstant))
        }
        
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: rightConstant))
        }
        
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        NSLayoutConstraint.activate(anchors)
        
        return anchors
    }

}
