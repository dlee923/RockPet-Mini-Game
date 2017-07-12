//
//  MonsterImg.swift
//  Gigapet
//
//  Created by Daniel Lee on 3/12/16.
//  Copyright © 2016 DLEE. All rights reserved.
//

import Foundation
import UIKit

class MonsterImg: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createGolum()
    }
    
    var imageArray = [UIImage]()
    
    func createGolum(){
        
        self.animationImages = nil
        
        for x in 1...4 {
            let image = UIImage(named: "idle\(x).png")
            imageArray.append(image!)
            
        }
        
        self.animationImages = imageArray
        self.animationDuration = 0.6
        self.animationRepeatCount = 0
        self.startAnimating()
    }
    
    func deathGolum(){
        
        self.animationImages = nil
        self.image = UIImage(named: "dead5.png")
        
        for x in 1...5 {
            let image = UIImage(named: "dead\(x).png")
            imageArray.append(image!)
        }
        
        self.animationImages = imageArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 1
        self.startAnimating()
    }
    
    
}
