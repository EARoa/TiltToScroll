//
//  ViewController.swift
//  TilttoScroll
//
//  Created by Efrain Ayllon on 7/14/16.
//  Copyright © 2016 Efrain Ayllon. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    var manager :CMMotionManager!
    @IBOutlet weak var textView: UITextView!
    weak var delegate: UITextViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = CMMotionManager()
        manager.deviceMotionUpdateInterval = 0.1
        manager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue()) { (data: CMDeviceMotion?, error: NSError?) in
            
            if let data = data {
                print(self.textView.contentOffset)
                print(data.gravity.y)
                
                let acceleration:CGFloat = 15
                let scrollViewHeight = self.textView.contentSize.height - self.textView.contentSize.height
                let upperBound = -0.83
                let lowerBound = -0.93
                
                if (data.gravity.y > upperBound) {
                    var y = CGFloat(self.textView.contentOffset.y + acceleration)
                    if (y < 0) {
                        y = 0
                    }
                    self.textView.setContentOffset(CGPointMake(0, y), animated: true)
                } else if (data.gravity.y < lowerBound) {
                    var y = CGFloat(self.textView.contentOffset.y - acceleration)
                    if (y > scrollViewHeight) {
                        y = scrollViewHeight
                    }
                    self.textView.setContentOffset(CGPointMake(0, y), animated: true)
                }
            }
        }
    }
}