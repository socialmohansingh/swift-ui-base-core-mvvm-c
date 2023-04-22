//
//  UITableView.swift
//  
//
//  Created by bemohansingh on 06/12/2021.
//

import Foundation
import UIKit

public extension UITableView {
    func register<C: UITableViewCell>(_ class: C.Type)  {
        register(C.self, forCellReuseIdentifier: C.identifier)
    }
    
    func dequeueCell<C: UITableViewCell>(_ class: C.Type, for indexPath: IndexPath) -> C {
        guard let cell = dequeueReusableCell(withIdentifier: C.identifier, for: indexPath) as? C else {
            fatalError("Unable to dequeue \(`class`.identifier) with reuseId of \(C.identifier)")
        }
        return cell
    }

}
