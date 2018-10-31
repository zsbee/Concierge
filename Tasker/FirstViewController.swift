//
//  FirstViewController.swift
//  Tasker
//
//  Created by Zsombor Fuszenecker on 2018. 09. 28..
//  Copyright © 2018. ZsomborFuszenceker. All rights reserved.
//

import UIKit
import Backpack

class FirstViewController: UIViewController {
    let addButton = Button(size: .large, style: .primary)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButton.translatesAutoresizingMaskIntoConstraints = false;
        addButton.setImage(Icon.makeIcon(name: .plus, color: .white, size: .large))
        addButton.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        
        self.view.addSubview(addButton)
    }

    override func viewSafeAreaInsetsDidChange() {
        // let topMargin = self.view.safeAreaInsets.top;
        
        NSLayoutConstraint.activate([
            addButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            addButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            ])
    }
    
    @objc func tappedButton(sender: UIButton!) {
        let modalController = NewTaskViewController()
        self.present(modalController, animated: true, completion: nil)
    }
    
}

