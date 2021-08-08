//
//  GenerateWordViewController.swift
//  Random
//
//  Created by 堅書真太郎 on 2021/06/10.
//

import UIKit

class GenerateWordViewController: UIViewController {
    
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var outputLabel: UILabel!
    
    var words: [String] = []
    
    override func viewDidLoad() {
        loadWordlist()
        outputLabel.text = words.randomElement()!
    }
    
    @IBAction func copyOutput(_ sender: Any) {
        UIPasteboard.general.string = outputLabel.text!
    }
    
    @IBAction func generate(_ sender: Any) {
        outputLabel.text = words.randomElement()!
    }
    
    func loadWordlist() {
        let path = Bundle.main.path(forResource: "Wordlist", ofType: "txt")!
        do {
            let wordlist: String = try String(contentsOfFile: path, encoding: .utf8)
            words = wordlist.components(separatedBy: .newlines)
        } catch {
            words = []
        }
    }
    
}
