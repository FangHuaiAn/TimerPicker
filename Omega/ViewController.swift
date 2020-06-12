//
//  ViewController.swift
//  Omega
//
//  Created by ntust04 on 2020/6/12.
//  Copyright © 2020 ntust04. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var timer : Timer!
    
    @IBOutlet weak var datePicker : UIDatePicker!
    @IBOutlet weak var LeftLabel: UILabel!
    @IBOutlet weak var StartButton: UIButton!
    @IBOutlet weak var StopButton: UIButton!
    
    var player: AVAudioPlayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        self.StopButton.isUserInteractionEnabled = false
        self.StopButton.setTitleColor(.lightGray, for: .normal)
        
    }
    
    
    @IBAction func StartButtonClicked(_ sender: UIButton) {
        
        self.LeftLabel.text = ""
        self.StopButton.isUserInteractionEnabled = true
        self.StopButton.setTitleColor(.white, for: .normal)
        self.datePicker.isHidden = true
        
        if let url = Bundle.main.url(forResource: "test", withExtension: "mp3") {
           player = try? AVAudioPlayer(contentsOf: url)
           player?.play()
        }
        
        
        var second = datePicker.countDownDuration
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){
            
            (timer)
            
            in
            
            guard second >= 0 else{
                timer.invalidate()
                
                DispatchQueue.main.async {
                    self.StartButton.isUserInteractionEnabled = true
                    self.StartButton.setTitleColor(.white, for: .normal)
                    
                    self.datePicker.isHidden = false
                    self.StopButton.isUserInteractionEnabled = false
                    self.StopButton.setTitleColor(.lightGray, for: .normal)
                }
                return
            }
            
            print("剩餘\(second)秒")
            
            DispatchQueue.main.async {
                
                if second > 0 {
                    self.LeftLabel.text = "剩餘\(second)秒"
                }
            }
            
            second -= 1
        }
        
        self.StartButton.isUserInteractionEnabled = false
        self.StartButton.setTitleColor(.lightGray, for: .normal)
        self.datePicker.isHidden = true
        
    }
    
    @IBAction func StopButtonClicked(_ sender: UIButton) {
        
        timer.invalidate()
        DispatchQueue.main.async {
            self.StartButton.isUserInteractionEnabled = true
            self.StartButton.setTitleColor(.white, for: .normal)
            
            self.datePicker.isHidden = false
            self.StopButton.isUserInteractionEnabled = false
            self.StopButton.setTitleColor(.lightGray, for: .normal)
            
            
            
            self.player?.stop()
        }
    }
    

}

