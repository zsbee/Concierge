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

class NewTaskHeaderCell: BaseCell {
    let label = Label(fontStyle: .textLgEmphasized)
    let discardButton = Button(size: .default, style: .destructive)
    weak var delegate: NewTaskHeaderCellDelegate?
    var model: HeaderModel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.createViews()
        self.addViews()
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
        discardButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        discardButton.setContentHuggingPriority(.required, for: .horizontal)

    }
    
    @objc func discardTapped(sender: UIButton!) {
        delegate?.header_deleteTappedWithModel(model: self.model)
    }
    
    public func setModel(model: HeaderModel) {
        self.model = model
        label.text = model.title;
        
        self.createConstraints()
    }
    
    func createConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        discardButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: BPKSpacingMd),
                label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: BPKSpacingBase),
                label.trailingAnchor.constraint(equalTo: discardButton.leadingAnchor, constant: -BPKSpacingBase),
                label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -BPKSpacingMd),

                discardButton.centerYAnchor.constraint(equalTo: label.centerYAnchor),
                discardButton.trailingAnchor.constraint(equalTo: self.discardButton.superview!.trailingAnchor, constant: -BPKSpacingBase),
            ])
    }
    
    func addViews() {
        self.contentView.addSubview(label)
        self.contentView.addSubview(discardButton)
    }
}
