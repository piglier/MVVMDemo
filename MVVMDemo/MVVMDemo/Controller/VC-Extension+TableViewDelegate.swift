//
//  VC-Extension+TableViewDelegate.swift
//  MVVMDemo
//
//  Created by PIG on 2023/1/25.
//

import Foundation
import UIKit

// MARK: - UITableView Delegate

extension MainViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("didSelected: \(indexPath.row)")
        performSegue(withIdentifier: "DetailSegue", sender: indexPath.row)
    }
    
}
