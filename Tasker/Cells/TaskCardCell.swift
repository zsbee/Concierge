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
    let card = Card(padded: false, cornerStyle: .large)
    
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
    }
    
    public func setModel(model: TaskViewModel) {
        self.createConstraints()
    }
    
    func createConstraints() {
        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            card.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            card.heightAnchor.constraint(equalToConstant: 300),
            card.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: BPKSpacingBase),
            card.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -BPKSpacingBase),
            ])
    }
    
    func addViews() {
        self.contentView.addSubview(card)
    }
}
