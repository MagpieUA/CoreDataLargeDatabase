//
//  UITableView+Xib.swift
//  RandomUserCoreData
//
//  Created by Mykhailo Sorokin on 4/12/19.
//  Copyright © 2019 Mykhailo Sorokin. All rights reserved.
//

import Foundation
import UIKit

protocol Reusable: class {
    static var reuseIdentifier: String { get }
    static var nibName: String { get }
}

extension Reusable {
    static var reuseIdentifier: String { return String(describing: self) }
    static var nibName: String { return String(describing: self) }
}

extension UITableView {
    func registerNib<T: UITableViewCell>(_: T.Type) where T: Reusable {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerHeaderFooterNib<T: UIView>(_: T.Type) where T: Reusable {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerReusableCell<T: UITableViewCell>(_: T.Type) where T: Reusable {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T where T: Reusable {
        return dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ : T.Type) -> T where T: Reusable {
        return dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as! T
    }
}
