//
//  NSLayoutConstraint+Ext.swift
//  LululemonChallenge
//
//  Created by Jason Dhindsa on 2021-08-28.
//

import UIKit

extension NSLayoutConstraint {
    func activate(withIdentifier id: String) {
        (self.identifier, self.isActive) = (id, true)
    }
}
