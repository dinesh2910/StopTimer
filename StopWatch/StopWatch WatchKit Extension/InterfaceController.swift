//
//  InterfaceController.swift
//  StopWatch WatchKit Extension
//
//  Created by Dinesh Danda on 4/11/20.
//  Copyright © 2020 Dinesh Danda. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    @IBOutlet weak var timeDisplayLabel: WKInterfaceLabel!
    @IBOutlet weak var startBtnOutlet: WKInterfaceButton!
    @IBOutlet weak var pauseBtnOutlet: WKInterfaceButton!
    @IBOutlet weak var resetBtnOutlet: WKInterfaceButton!
    
    
    var timer = Timer()
    var isTimerRunning: Bool = false
    var counter = 0.0
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        setupUI()
        configureButtons()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func configureButtons() {
        resetBtnOutlet.setEnabled(false)
        pauseBtnOutlet.setEnabled(false)
        startBtnOutlet.setEnabled(true)
    }
    
    func setupUI() {
        startBtnOutlet.setBackgroundColor(.green)
        pauseBtnOutlet.setBackgroundColor(.red)
        startBtnOutlet.setTitle("Start")
        pauseBtnOutlet.setTitle("Pause")
        resetBtnOutlet.setTitle("Reset")
    }
    
    @IBAction func didPressStartBtn() {
        if !isTimerRunning {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(runTimer), userInfo: nil, repeats: true)
            
            isTimerRunning = true
            resetBtnOutlet.setEnabled(true)
            pauseBtnOutlet.setEnabled(true)
            startBtnOutlet.setEnabled(false)
        }
    }
    
    @IBAction func didPressPauseBtn() {
        resetBtnOutlet.setEnabled(false)
        pauseBtnOutlet.setEnabled(false)
        startBtnOutlet.setEnabled(true)
        isTimerRunning = false
        timer.invalidate()
    }
    
    @IBAction func didPressResetBtn() {
        timer.invalidate()
        isTimerRunning = false
        counter = 0.0
        timeDisplayLabel.setText("00:00:00")
        resetBtnOutlet.setEnabled(false)
        pauseBtnOutlet.setEnabled(false)
        startBtnOutlet.setEnabled(true)
    }
    
    
    @objc func runTimer() {
        counter += 1
        // You need timer label in HH:MM:SS... format
        
        let finalTimerCount = Int(floor(counter))
        let hour = finalTimerCount / 3600
        let minute = (finalTimerCount % 3600) / 60
        var minuteString = "\(minute)"
        if minute < 10 {
            minuteString = "0\(minute)"
        }
        let second = (finalTimerCount % 3600) % 60
        var secondString = "\(second)"
        if second < 10 {
            secondString = "0\(second)"
        }
        // If you want to use the 00:00:00.0 add the decimalString in finalTimerLabel
        //let decimalString = String(format: "%.1f", counter).components(separatedBy: ".").last!
        let finalTimerLabel: String = "\(hour):\(minuteString):\(secondString)"
        timeDisplayLabel.setText(finalTimerLabel)
    }
}
