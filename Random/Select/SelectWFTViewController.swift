//
//  SelectWFTViewController.swift
//  Random
//
//  Created by 堅書真太郎 on 2021/06/12.
//

import UIKit

class SelectWFTViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var outputLabel: UILabel!
    
    var words: [String] = []
    var selectedIndex: Int = -1
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        textView.layer.cornerRadius = 6.0
    }
    
    // MARK: Interface Builder
    
    @IBAction func clearText(_ sender: Any) {
        textView.text = ""
        outputLabel.text = "No Word Selected"
        selectedIndex = -1
        
    }
    
    @IBAction func copyOutput(_ sender: Any) {
        if (outputLabel.text == "No Word Selected") {
            let alert = UIAlertController(title: "No Word To Copy",
                                          message: "Select a word, then try again.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Got It",
                                          style: .cancel,
                                          handler: nil))
            UINotificationFeedbackGenerator().notificationOccurred(.error)
            present(alert, animated: true, completion: nil)
        } else {
            UIPasteboard.general.string = outputLabel.text!
        }
    }
    
    @IBAction func selectRandom(_ sender: Any) {
        if (textView.text == "") {
            let alert = UIAlertController(title: "No Text To Select From",
                                          message: "Add some text, then try again.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Got It",
                                          style: .cancel,
                                          handler: nil))
            UINotificationFeedbackGenerator().notificationOccurred(.error)
            present(alert, animated: true, completion: nil)
        } else {
            selectNewItem()
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        view.endEditing(false)
    }
    
    // MARK: Helper Functions
    
    func selectNewItem() {
        words = textView.text.components(separatedBy: CharacterSet.letters.inverted)
        words.removeAll { string in
            return string == ""
        }
        selectedIndex = Int.random(in: 0...(words.count - 1))
        outputLabel.text = words[selectedIndex].localizedCapitalized
    }
    
}
