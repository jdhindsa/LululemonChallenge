//
//  JDLabel.swift
//  LululemonChallenge
//
//  Created by Jason Dhindsa on 2021-08-28.
//

import UIKit

class JDLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(text: String) {
        self.init(frame: .zero)
        self.text = text
    }
    
    convenience init(text: String, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.text = text
        
        font = UIFont(name: "Courier", size: fontSize)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .black
    }
}
