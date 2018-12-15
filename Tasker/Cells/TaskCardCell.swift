//
//  TaskCard.swift
//  Tasker
//
//  Created by Zsombor Fuszenecker on 2018. 12. 07..
//  Copyright © 2018. ZsomborFuszenceker. All rights reserved.
//

import Foundation
import Backpack

class TaskCardCell: BaseCell {
    let card = Card(padded: true, cornerStyle: .large)
    let containerView = UIView()
    let descriptionLabel = Label(fontStyle: .textBase)
    
    let authorLabel = Label(fontStyle: .textBaseEmphasized)
    let avatar = UIImageView(image: Icon.makeIcon(name: .accountCircle, color: Color.green700, size: .large))
    
    let moneyLabel = Label(fontStyle: .textBaseEmphasized)
    let money = UIImageView(image: Icon.makeIcon(name: .money, color: Color.green700, size: .large))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
        self.addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        card.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        avatar.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        money.translatesAutoresizingMaskIntoConstraints = false
        moneyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.numberOfLines = 3
        
        containerView.addSubview(avatar)
        containerView.addSubview(authorLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(moneyLabel)
        containerView.addSubview(money)
        
        card.subview = containerView
    }
    
    public func setModel(model: TaskViewModel) {
        descriptionLabel.text = model.taskDescription()
        authorLabel.text = "Tamas Z."
        moneyLabel.text = "3200 Ft"
        self.createConstraints()
    }
    
    func createConstraints() {
        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            card.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            card.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: BPKSpacingBase),
            card.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -BPKSpacingBase),
            
            avatar.topAnchor.constraint(equalTo: avatar.superview!.topAnchor),
            avatar.leadingAnchor.constraint(equalTo: avatar.superview!.leadingAnchor),
            authorLabel.centerYAnchor.constraint(equalTo: avatar.centerYAnchor),
            authorLabel.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: BPKSpacingMd),
            authorLabel.trailingAnchor.constraint(lessThanOrEqualTo: authorLabel.superview!.trailingAnchor),
            
            money.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: BPKSpacingMd),
            money.bottomAnchor.constraint(lessThanOrEqualTo: descriptionLabel.topAnchor, constant: -BPKSpacingBase),
            money.leadingAnchor.constraint(equalTo: money.superview!.leadingAnchor),
            moneyLabel.centerYAnchor.constraint(equalTo: money.centerYAnchor),
            moneyLabel.leadingAnchor.constraint(equalTo: money.trailingAnchor, constant: BPKSpacingMd),
            moneyLabel.trailingAnchor.constraint(lessThanOrEqualTo: moneyLabel.superview!.trailingAnchor),
            
            descriptionLabel.bottomAnchor.constraint(equalTo: descriptionLabel.superview!.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionLabel.superview!.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: descriptionLabel.superview!.trailingAnchor),
            ])
    }
    
    func addViews() {
        self.contentView.addSubview(card)
    }
}
