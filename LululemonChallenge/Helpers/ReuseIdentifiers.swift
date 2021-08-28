//
//  ReuseIdentifiers.swift
//  LululemonChallenge
//
//  Created by Jason Dhindsa on 2021-08-28.
//

import UIKit

protocol ReuseIdentifiable {
    static func reuseIdentifier() -> String
}

extension ReuseIdentifiable {
    static func reuseIdentifier() -> String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReuseIdentifiable {}
