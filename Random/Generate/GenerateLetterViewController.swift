//
//  GenerateLetterViewController.swift
//  Random
//
//  Created by 堅書真太郎 on 2021/06/10.
//

import UIKit

class GenerateLetterViewController: UIViewController {
    
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var outputLabel: UILabel!
    
    override func viewDidLoad() {
        let letterIndex: Int = Int.random(in: 0...25)
        outputLabel.text = String(Character(UnicodeScalar(65 + letterIndex)!))
    }
    
    @IBAction func copyOutput(_ sender: Any) {
        UIPasteboard.general.string = outputLabel.text!
    }
    
    @IBAction func generate(_ sender: Any) {
        
        let letterIndex: Int = Int.random(in: 0...25)
        outputLabel.text = String(Character(UnicodeScalar(65 + letterIndex)!))
        
    }
    
}
