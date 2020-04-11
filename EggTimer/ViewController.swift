//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    var timer = Timer()
    var totalSeconds: Float?
    var currentSeconds: Float = 0;
    var hardness: [String: Float]  = [
        "Soft": 10,
        "Medium": 60 * 7,
        "Hard": 60 * 12
    ]

    @IBAction func keyPressed(_ sender: UIButton) {
        timer.invalidate()
        progressBar.progress=0.0
        currentSeconds=0
        titleLabel.text=sender.currentTitle!
        totalSeconds = hardness[sender.currentTitle!]
        runTimer()
    }
    
    func runTimer() {
         timer = Timer.scheduledTimer(timeInterval: 1,
                                      target: self,
                                      selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if  currentSeconds < totalSeconds! {
            print(currentSeconds)
            currentSeconds+=1
            let progress = currentSeconds/totalSeconds!;
            progressBar.progress = progress;
            if progress == 1.0 {
                playSound()
                titleLabel.text = "Done"
                timer.invalidate()
            }
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alert", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
}
