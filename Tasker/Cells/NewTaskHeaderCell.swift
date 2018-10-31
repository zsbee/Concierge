//
//  NewTaskHeaderCell.swift
//  Tasker
//
//  Created by Zsombor Fuszenecker on 2018. 10. 25..
//  Copyright © 2018. ZsomborFuszenceker. All rights reserved.
//

import UIKit
import Backpack

protocol NewTaskHeaderCellDelegate: class {
    func header_deleteTappedWithModel(model: HeaderModel)
}

class NewTaskHeaderCell: UICollectionViewCell {
    let label = Label(fontStyle: .textLgEmphasized)
    let discardButton = Button(size: .default, style: .destructive)
    weak var delegate: NewTaskHeaderCellDelegate?
    var model: HeaderModel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.createViews()
        self.addViews()
        self.createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createViews() {
        label.font = UIFont.systemFont(ofSize: 40, weight: .heavy)
        label.textAlignment = .left
        label.numberOfLines = 1
        
        discardButton.setImage(Icon.makeIcon(name: .minus, color: .black, size: .small))
        discardButton.addTarget(self, action: #selector(discardTapped), for: .touchUpInside)
    }
    
    @objc func discardTapped(sender: UIButton!) {
        delegate?.header_deleteTappedWithModel(model: self.model)
    }
    
    public func setModel(model: HeaderModel) {
        self.model = model
        label.text = model.title;
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    func createConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        discardButton.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.setContentCompressionResistancePriority(.required, for: .horizontal)
        self.contentView.setContentHuggingPriority(.defaultLow, for: .horizontal)

        NSLayoutConstraint.activate([
                self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
                self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
                self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
                self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            
                label.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
                label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: BPKSpacingBase),
                label.trailingAnchor.constraint(equalTo: self.discardButton.leadingAnchor, constant: -BPKSpacingBase),
                
                discardButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
                discardButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -BPKSpacingBase)
            ])
    }
    
    func addViews() {
        self.contentView.addSubview(label)
        self.contentView.addSubview(discardButton)
    }
}
