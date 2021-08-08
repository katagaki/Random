//
//  MoreTableViewController.swift
//  Random
//
//  Created by 堅書真太郎 on 2021/06/06.
//

import SafariServices
import UIKit

class MoreTableViewController: UITableViewController, SFSafariViewControllerDelegate {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            switch indexPath.row {
            case 0:
                let urlString = "https://zento.systems"
                if let url = URL(string: urlString) {
                    let safariViewController = SFSafariViewController(url: url)
                    safariViewController.delegate = self
                    present(safariViewController, animated: true)
                }
            case 1:
                let urlString = "https://twitter.com/katagaki_"
                if let url = URL(string: urlString) {
                    let safariViewController = SFSafariViewController(url: url)
                    safariViewController.delegate = self
                    present(safariViewController, animated: true)
                }
            default: break
            }
        default: break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
