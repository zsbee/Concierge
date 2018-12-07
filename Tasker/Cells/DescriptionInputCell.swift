//
//  DescriptionInputCell.swift
//  Tasker
//
//  Created by Zsombor Fuszenecker on 2018. 10. 31..
//  Copyright © 2018. ZsomborFuszenceker. All rights reserved.
//

import UIKit
import Backpack
import UITextView_Placeholder

class DescriptionInputCell: BaseCell {
    
    let textView = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
        self.addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        textView.font = Font.makeFont(style: .textBase)
        textView.layer.cornerRadius = 4
        textView.backgroundColor = UIColor.init(displayP3Red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
        textView.placeholderLabel.font = Font.makeFont(style: .textBase)
    }
    
    public func setModel(model: TaskDescriptionViewModel) {
        textView.placeholder = model.placeHolder
        textView.placeholderColor = UIColor.lightGray
        
        textView.text = model.title
        
        self.createConstraints()
    }
    
    func createConstraints() {
        textView.translatesAutoresizingMaskIntoConstraints = false;
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            textView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            textView.heightAnchor.constraint(equalToConstant: 150),
            textView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: BPKSpacingBase),
            textView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -BPKSpacingBase),
        ])
    }
    
    func addViews() {
        self.contentView.addSubview(textView)
    }
}
