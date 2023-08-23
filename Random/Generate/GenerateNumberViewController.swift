//
//  GenerateNumberViewController.swift
//  Random
//
//  Created by シンジャスティン on 2021/06/10.
//

import UIKit

class GenerateNumberViewController: UIViewController {
    
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var outputLabel: UILabel!
    
    var numFrom: Int = 1
    var numTo: Int = 100
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        outputLabel.text = String(Int.random(in: numFrom...numTo))
    }
    
    // MARK: Interface Builder
    
    @IBAction func copyOutput(_ sender: Any) {
        UIPasteboard.general.string = outputLabel.text!
        view.endEditing(false)
    }
    
    @IBAction func generate(_ sender: Any) {
        
        numFrom = Int(fromTextField.text!)!
        numTo = Int(toTextField.text!)!
        
        if numTo <= numFrom {
            let alert = UIAlertController(title: "Invalid Range",
                                          message: "Please enter a valid range and try again.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Got It",
                                          style: .cancel,
                                          handler: nil))
            UINotificationFeedbackGenerator().notificationOccurred(.error)
            present(alert, animated: true, completion: nil)
        } else {
            outputLabel.text = String(Int.random(in: numFrom...numTo))
        }
        view.endEditing(false)
        
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        view.endEditing(false)
    }
    
}
