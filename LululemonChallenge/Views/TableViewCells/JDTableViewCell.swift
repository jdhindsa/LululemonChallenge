//
//  JDTableViewCell.swift
//  LululemonChallenge
//
//  Created by Jason Dhindsa on 2021-08-28.
//

import UIKit

class JDTableViewCell: UITableViewCell {
    
    var garmentViewModel: JDGarmentViewModel! {
        didSet {
            textLabel?.text = garmentViewModel.garmentName
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        contentView.backgroundColor = isHighlighted ? .gray : .white
        textLabel?.textColor = isHighlighted ? UIColor.white : .black
    }
    
    private func configure() {
        textLabel?.font = UIFont(name: "Courier", size: 18)
        textLabel?.numberOfLines = 0
    }
}
