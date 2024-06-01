//
//  UITableView+Extenion.swift
//  nearby
//
//  Created by Manoj Chvan on 01/06/24.
//

import Foundation
import UIKit


protocol Reusable {
    static var cellId: String { get }
}

extension Reusable {
    static var cellId: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable {}

extension UIView {
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}


extension UITableView {
    func registerNib<T: UITableViewCell>(type: T.Type) {
        register(type.nib, forCellReuseIdentifier: T.cellId)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(type: T.Type, indexPath: IndexPath) -> T {

           return dequeueReusableCell(withIdentifier: T.cellId, for: indexPath) as! T
       }
}
