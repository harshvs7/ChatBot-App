//
//  ViewController.swift
//  ChatGPTChatBot
//
//  Created by Harshvardhan Sharma on 10/12/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var btnStart: UIButton!

    var timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.timerNav), userInfo: nil, repeats: false)
    }

    @objc func timerNav(){
        btnStart.isHidden = false
    }
    
    @IBAction func btnStartTapped(_ sender: Any) {
        let viewController = MainScreenViewController()
        viewController.navigationController?.isToolbarHidden = true
        self.navigationController?.pushViewController(viewController, animated: true)
        print("Hahaha")
    }

}

