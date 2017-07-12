//
//  ViewController.swift
//  Gigapet
//
//  Created by Daniel Lee on 3/11/16.
//  Copyright © 2016 DLEE. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var heart: DragImg!
    @IBOutlet weak var food: DragImg!
    @IBOutlet weak var golum: MonsterImg!
    @IBOutlet weak var skull1: UIImageView!
    @IBOutlet weak var skull2: UIImageView!
    @IBOutlet weak var skull3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        skull1.alpha = DIM_ALPHA
        skull2.alpha = DIM_ALPHA
        skull3.alpha = DIM_ALPHA
        
        food.dropTarget = golum
        heart.dropTarget = golum
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.feedTheGolum(_:)), name: NSNotification.Name(rawValue: "itemDroppedOnTarget"), object: nil)
        
        do {
            try musicPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "cave-music", ofType: "mp3")!))
            
            try sfxBite = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "bite", ofType: "wav")!))

            try sfxHeart = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "heart", ofType: "wav")!))
            
            try sfxSkull = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "skull", ofType: "wav")!))
            
            try sfxDeath = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "death", ofType: "wav")!))
            
        } catch{
            
        }
        
        startTimer()
        
        golumHappy = true

        disableHeart()
        disableFood()
        
        musicPlayer.prepareToPlay()
        musicPlayer.play()
        sfxHeart.prepareToPlay()
        sfxBite.prepareToPlay()
        sfxDeath.prepareToPlay()
        sfxSkull.prepareToPlay()

    }
    
    let DIM_ALPHA: CGFloat = 0.2
    let MAX_ALPHA: CGFloat = 1.0
    let MAX_PENALTY = 3
    var penaltyCount = 0
    var timer: Timer!
    var golumHappy: Bool!
    var sfxBite: AVAudioPlayer!
    var musicPlayer: AVAudioPlayer!
    var sfxDeath: AVAudioPlayer!
    var sfxHeart: AVAudioPlayer!
    var sfxSkull: AVAudioPlayer!
    var currentValue: UInt32!
    
    func startTimer(){
        
        if timer != nil{
            timer.invalidate()
        }
        
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(ViewController.checkIfFed), userInfo: nil, repeats: true)
        
    }
    
    func feedTheGolum(_ notif: AnyObject){
        startTimer()
        heart.isUserInteractionEnabled = false
        food.isUserInteractionEnabled = false
        golumHappy = true
        
        heart.alpha = DIM_ALPHA
        food.alpha = DIM_ALPHA
        
        if currentValue == 0 {
            sfxHeart.play()
        } else {
            sfxBite.play()
        }
    }
    
    func checkIfFed(){
        
        if !golumHappy {
        
            penaltyCount += 1
            sfxSkull.play()
        
            if penaltyCount == 1 {
                skull1.alpha = MAX_ALPHA
            } else if penaltyCount == 2 {
                skull2.alpha = MAX_ALPHA
                skull3.alpha = DIM_ALPHA
            } else if penaltyCount >= 3 {
                skull3.alpha = MAX_ALPHA
            } else {
                skull1.alpha = DIM_ALPHA
                skull2.alpha = DIM_ALPHA
                skull3.alpha = DIM_ALPHA
            }
            
            if penaltyCount == MAX_PENALTY {
                gameOver()
            }
        }
        
        let rand = arc4random_uniform(UInt32(2))
        
        currentValue = rand
        
        if rand == 0 {
            enableHeart()
            disableFood()
        } else {
            enableFood()
            disableHeart()
        }
        
        golumHappy = false
    }
    
    func gameOver(){
        timer.invalidate()
        golum.deathGolum()
        sfxDeath.play()
    }
    
    func disableHeart(){
        heart.alpha = DIM_ALPHA
        heart.isUserInteractionEnabled = false
    }
    
    func enableHeart(){
        heart.alpha = MAX_ALPHA
        heart.isUserInteractionEnabled = true
    }
    
    func disableFood(){
        food.alpha = DIM_ALPHA
        food.isUserInteractionEnabled = false
    }
    
    func enableFood(){
        food.alpha = MAX_ALPHA
        food.isUserInteractionEnabled = true
    }


}

