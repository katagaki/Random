//
//  SelectIFLViewController.swift
//  Random
//
//  Created by シンジャスティン on 2021/06/12.
//

import UIKit

class SelectIFLViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var outputLabel: UILabel!
    
    var items: [String] = []
    var selectedIndex: Int = -1
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        tableView.layer.cornerRadius = 6.0
    }
    
    // MARK: Interface Builder
    
    @IBAction func addItem(_ sender: Any) {
        items.append(itemTextField.text!)
        itemTextField.text = ""
        addButton.isEnabled = false
        tableView.reloadData()
    }
    
    @IBAction func removeAll(_ sender: Any) {
        items.removeAll()
        selectedIndex = -1
        outputLabel.text = "No Item Selected"
        tableView.reloadData()
    }
    
    @IBAction func textChanged(_ sender: Any) {
        if itemTextField.text != "" {
            addButton.isEnabled = true
        } else {
            addButton.isEnabled = false
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        if itemTextField.text != "" {
            addItem(addButton!)
        }
        view.endEditing(false)
    }
    
    @IBAction func copyOutput(_ sender: Any) {
        if (selectedIndex >= items.count || items.count == 0 || selectedIndex == -1) {
            let alert = UIAlertController(title: "No Item To Copy",
                                          message: "Add/select an item, then try again.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Got It",
                                          style: .cancel,
                                          handler: nil))
            UINotificationFeedbackGenerator().notificationOccurred(.error)
            present(alert, animated: true, completion: nil)
        } else {
            UIPasteboard.general.string = items[selectedIndex]
        }
    }
    
    @IBAction func selectRandom(_ sender: Any) {
        if (selectedIndex >= items.count || items.count == 0) {
            let alert = UIAlertController(title: "No Item To Select",
                                          message: "Add an item, then try again.",
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
    
    // MARK: UITableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell")!
        cell.textLabel?.text = items[indexPath.row]
        cell.accessoryType = (selectedIndex == indexPath.row ? .checkmark : .none)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    // MARK: Helper Functions
    
    func selectNewItem() {
        selectedIndex = Int.random(in: 0...(items.count - 1))
        outputLabel.text = items[selectedIndex]
        tableView.reloadData()
    }
    
}

