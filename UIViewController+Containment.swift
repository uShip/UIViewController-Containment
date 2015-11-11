//  UIViewController+Containment.swift
//
//  Created by Jason Pepas on 11/4/15.
//  Copyright © 2015 uShip.  All rights reserved.
//
//  This work is a derived work ("fork") of UIViewController+Container by Peter Paulis.
//  See https://github.com/peterpaulis/UIViewController--Container-
//
//  Peter's work was released under the terms of the Apache License 2.0,
//  therefore this work is also released under the Apache License 2.0.
//  See http://www.apache.org/licenses/LICENSE-2.0.txt
//
//  This work differs from Peter's in the following ways:
//  * Ported from Objective-C to Swift 2.0
//  * Assumes Auto Layout.

import UIKit

extension UIViewController
{
    func containChildViewController(childVC:UIViewController, inView containerView:UIView)
    {
        addChildViewController(childVC)
        containerView.addSubview(childVC.view)
        childVC.didMoveToParentViewController(self)
        containerView.bringSubviewToFront(childVC.view)
        
        childVC.view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func containChildViewController(child:UIViewController)
    {
        self.containChildViewController(child, inView:view)
    }
}

extension UIViewController
{
    func containPinnedChildViewController(childVC:UIViewController, inView containerView:UIView)
    {
        containChildViewController(childVC, inView: containerView)
        
        for attribute: NSLayoutAttribute in [.Leading, .Top, .Bottom, .Trailing]
        {
            containerView.addConstraint(NSLayoutConstraint(item:containerView,
                attribute: attribute,
                relatedBy: .Equal,
                toItem: childVC.view,
                attribute: attribute,
                multiplier: 1,
                constant: 0))
        }
        
        containerView.layoutIfNeeded()
    }
    
    func containPinnedChildViewController(childVC:UIViewController)
    {
        containPinnedChildViewController(childVC, inView:view)
    }
}
