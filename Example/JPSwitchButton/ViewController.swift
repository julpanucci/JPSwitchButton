//
//  ViewController.swift
//  JPSwitchButton
//
//  Created by julp04 on 08/24/2017.
//  Copyright (c) 2017 julp04. All rights reserved.
//

import UIKit
import JPSwitchButton

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.lightGray
        
        let buttonHeight = CGFloat(176.0)
        let buttonFrame = CGRect(x: 16, y: view.frame.height / 2.0 - buttonHeight, width: 343, height: buttonHeight)
        let blue = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        let switchButton = JPSwitchButton(frame: buttonFrame, offColor: .white, onColor: blue, image: nil, title: "Press me to turn on", description: "Currently I am off", isOn: false)
        switchButton.onClick =  {
            
            switchButton.switchState()
            
            switchButton.buttonTitle = switchButton.isOn ? "Press me to turn off" : "Press me to turn on"
            switchButton.buttonDescription = switchButton.isOn ? "Currently I am on" : "Currently I am off"
        }
        
        switchButton.onLongPress =  {
            let alert = UIAlertController(title: "Long press", message: "Long press on button", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        
        
        let buttonFrame2 = CGRect(x: 16, y: view.frame.height / 2.0 + 10, width: 343, height: buttonHeight)
        let twitterBlue = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        let twitterButton = JPSwitchButton(frame: buttonFrame2, offColor: .white, onColor: twitterBlue, image: #imageLiteral(resourceName: "twitter_on"), title: "Connect with Twitter", description: "Add your twitter account!")
        
        let username = "julp04"
        
        twitterButton.onClick =  {
            twitterButton.switchState()
            
            twitterButton.buttonTitle = twitterButton.isOn ? username: "Connect with Twitter"
            twitterButton.buttonDescription = twitterButton.isOn ? "Long press to follow me!" : "Add your twitter account"
        }
        
        twitterButton.onLongPress =  {
            if twitterButton.isOn {
                let url = URL(string: "http://twitter.com/\(username)")!
                UIApplication.shared.openURL(url)
            }
        }
        
        
        view.addSubview(twitterButton)
        
        view.addSubview(switchButton)
    }


}

