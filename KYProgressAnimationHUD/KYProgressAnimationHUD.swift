//
//  KYProgressAnimationHUD.swift
//  KYProgressAnimationHUD
//
//  Created by KangYang on 16/2/9.
//  Copyright © 2016年 KangYang. All rights reserved.
//

import UIKit

class KYProgressAnimationHUD: UIView {
    
    lazy var animationView: UIImageView = UIImageView();
    
    //MARK: publich method
    
    class func showDefaultAnimation() {
        let images: [UIImage] = [
            UIImage(named: "frame_animation_0")!,
            UIImage(named: "frame_animation_1")!,
            UIImage(named: "frame_animation_2")!,
            UIImage(named: "frame_animation_3")!];
        self.showWithImages(images);
    }
    
    class func showWithImages(images: [UIImage]) {
        self.shareView._showWithImages(images);
    }
    
    class func dismiss() {
        self.shareView._stopAnimation();
        
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.shareView.alpha = 0.0;
            }) { (finished) -> Void in
                self.shareView.removeFromSuperview();
        }
    }
    
    //MARK: private method
    
    private class var shareView: KYProgressAnimationHUD {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: KYProgressAnimationHUD? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = KYProgressAnimationHUD(frame: UIScreen.mainScreen().bounds);
            Static.instance?.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.3);
        }
        return Static.instance!;
    }
    
    private func _showWithImages(images: [UIImage]) {
        if self.superview == nil {
            let frontToBackWindows = UIApplication.sharedApplication().windows;
            
            for (var i = 0; i < frontToBackWindows.count; i++) {
                let window = frontToBackWindows[i];
                
                let windowOnMainScreen = window.screen == UIScreen.mainScreen();
                let windowIsVisible = window.hidden == false && window.alpha > 0;
                let windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
                
                if windowOnMainScreen && windowIsVisible && windowLevelNormal {
                    window.addSubview(self);
                    break;
                }
            }
        } else {
            self.superview?.bringSubviewToFront(self);
        }
        
        if self.animationView.superview == nil {
            self.addSubview(self.animationView);
        }
        
        self.animationView.frame = CGRectMake(0, 0, (images.first?.size.width)!, (images.first?.size.height)!);
        self.animationView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        self.animationView.animationImages = images;
        self.animationView.animationRepeatCount = NSIntegerMax;
        self.animationView.animationDuration = 0.4;
        
        if self.animationView.isAnimating() == false {
            self.animationView.startAnimating();
        }
        
        self.alpha = 0.0;
        UIView.animateWithDuration(0.25, animations: {
            self.alpha = 1.0;
        });
    }
    
    private func _stopAnimation() {
        if animationView.isAnimating() {
            animationView.stopAnimating();
        }
    }
}
