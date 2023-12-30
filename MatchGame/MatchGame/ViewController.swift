//
//  ViewController.swift
//  MatchGame
//
//  Created by Нурсат Шохатбек on 29.12.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var state = Array(repeating: false, count: 16)
    
    var images = [
        "gul1", "gul2", "gul3", "gul4", "gul5", "gul6", "gul7", "gul8",
        "gul1", "gul2", "gul3", "gul4", "gul5", "gul6", "gul7", "gul8"
    ].shuffled()
    
    var isOpened = false
    var lastButtonTag = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func matchGame(_ sender: UIButton)  {
        if lastButtonTag != sender.tag && state[sender.tag - 1] == false {
            let image = images[sender.tag - 1]
            
            sender.setBackgroundImage(UIImage(named: image), for: .normal)
            
            
            if isOpened {
                let lastImage = images[lastButtonTag - 1]
                
                if lastImage == image {
                    state[sender.tag - 1] = true
                    state[lastButtonTag - 1] = true
                    
                    if state.allSatisfy({ $0 }) {
                        showWinAlert()
                    }
                     
                }else {
                    view.isUserInteractionEnabled = false
                    
                    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
                        let lastButton = self.view.viewWithTag(self.lastButtonTag) as! UIButton
                 
                        lastButton.setBackgroundImage(nil, for: .normal)
                        sender.setBackgroundImage(nil, for: .normal)
                        
                        self.view.isUserInteractionEnabled = true
                        
                    }
            }
                
            } else {
                lastButtonTag = sender.tag
                
            }

            isOpened.toggle()
     
        }
       
     
    }
    func showWinAlert() {
            let alertController = UIAlertController(title: "You Win!", message: "Congratulations! You have matched all pairs.", preferredStyle: .alert)
                
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
           
           
            present(alertController, animated: true, completion: nil)
            resetGame()
            
        }
    
    func resetGame() {
            state = Array(repeating: false, count: 16)
            images = images.shuffled()
            isOpened = false
            lastButtonTag = 0
            
        for tag in 1...16 {
                    if let button = view.viewWithTag(tag) as? UIButton {
                        button.setBackgroundImage(nil, for: .normal)
                    }
                }
        }
    
}

