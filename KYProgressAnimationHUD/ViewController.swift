//
//  ViewController.swift
//  KYProgressAnimationHUD
//
//  Created by KangYang on 16/2/9.
//  Copyright © 2016年 KangYang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        KYProgressAnimationHUD.showDefaultAnimation();
        
        let time: NSTimeInterval = 5.0;
        let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)));
        dispatch_after(delay, dispatch_get_main_queue(), {
            KYProgressAnimationHUD.dismiss();
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

