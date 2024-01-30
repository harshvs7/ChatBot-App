//
//  MainViewController.swift
//  ChatGPTChatBot
//
//  Created by Harshvardhan Sharma on 10/12/2023.
//

import UIKit

class MainScreenViewController: UIViewController {
    
    
    //MARK: IBOutlets
    @IBOutlet weak var btnStart: UIButton!

    //MARK: LifeCycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: IBActions
    @IBAction func btnStartPressed(sender: UIButton){
        let controller = MessageScreenViewController()
        controller.title = "Chat Bot"
        self.navigationController?.pushViewController(controller, animated: true)
    }

    
}
