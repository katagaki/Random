//
//  GenerateTableViewController.swift
//  Random
//
//  Created by シンジャスティン on 2021/06/06.
//

import UIKit

class GenerateTableViewController: UITableViewController {
    
    // MARK: UITableViewController
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
