//
//  FirstViewController.swift
//  Tasker
//
//  Created by Zsombor Fuszenecker on 2018. 09. 28..
//  Copyright © 2018. ZsomborFuszenceker. All rights reserved.
//

import UIKit
import Backpack

class FirstViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let addButton = Button(size: .large, style: .primary)
    let titleLabel = Label(fontStyle: .textXxlHeavy)
    var tasks: [TaskViewModel]!
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setImage(Icon.makeIcon(name: .plus, color: .white, size: .large))
        addButton.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        
        titleLabel.text = "Böngészés"
        self.tasks = self.dummyTasks()

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = BPKSpacingBase
        layout.minimumLineSpacing = BPKSpacingBase
        layout.sectionInset = UIEdgeInsets(top: BPKSpacingMd, left: 0, bottom: 3*BPKSpacingXxl, right: 0)
        layout.estimatedItemSize = CGSize(width: self.view.frame.width, height: 100)
        collectionView = UICollectionView(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.register(TaskCardCell.self, forCellWithReuseIdentifier: "taskCard")
        collectionView.translatesAutoresizingMaskIntoConstraints = false;

        self.view.addSubview(titleLabel)
        self.view.addSubview(collectionView)
        self.view.addSubview(addButton)

        collectionView.reloadData()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = self.tasks[indexPath.row]

        if (model.id == TaskViewModel.identifier) {
            let taskCell: TaskCardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "taskCard", for: indexPath) as! TaskCardCell
            taskCell.width = collectionView.frame.width
            taskCell.setModel(model: model)
            return taskCell
        }

        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = self.tasks[indexPath.row]
        
        
    }
    
    override func viewSafeAreaInsetsDidChange() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: BPKSpacingBase),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant:BPKSpacingBase),
            
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: BPKSpacingMd),
            collectionView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor, constant: 0),
            
            addButton.widthAnchor.constraint(equalToConstant: 65),
            addButton.heightAnchor.constraint(equalToConstant: 65),
            addButton.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor, constant: -BPKSpacingLg),
            addButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -BPKSpacingLg)
            ])
    }
    
    @objc func tappedButton(sender: UIButton!) {
        let modalController = NewTaskViewController()
        self.present(modalController, animated: true, completion: nil)
    }
    
    func dummyTasks() -> [TaskViewModel] {
        var items:[TaskViewModel] = []
        for _ in 0...14 {
            items.append(NewTaskViewController.createDummyModel())
        }
        
        return items
    }
    
}

