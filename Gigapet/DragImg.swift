//
//  DragImg.swift
//  Gigapet
//
//  Created by Daniel Lee on 3/11/16.
//  Copyright © 2016 DLEE. All rights reserved.
//

import Foundation
import UIKit

class DragImg: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var originalImagePosition: CGPoint!
    var dropTarget: UIView?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        originalImagePosition = self.center
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            let position = touch.location(in: self.superview)
            self.center = CGPoint(x: position.x, y: position.y)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first, let target = dropTarget{
            
            let position = touch.location(in: self.superview)
            
            if dropTarget!.frame.contains(position) {
                NotificationCenter.default.post(name: Notification.Name(rawValue: "itemDroppedOnTarget"), object: nil)
            }
        }
        
        self.center = originalImagePosition
    }
    
}
