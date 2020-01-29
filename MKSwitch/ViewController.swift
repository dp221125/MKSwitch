//
//  ViewController.swift
//  NewSwitch
//
//  Created by Seokho on 2020/01/29.
//  Copyright © 2020 Seokho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    weak var newSwitchStatusLabel: UILabel?
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemBackground
        self.view = view
        
        let newSwitch = MKSwitch()
        view.addSubview(newSwitch)
        newSwitch.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newSwitch.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            newSwitch.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        ])
        newSwitch.addTarget(self, action: #selector(switchStateChanged(_:)), for: .valueChanged)
        
        let label = UILabel()
        label.textColor = .label
        self.newSwitchStatusLabel = label
        label.text = "\(newSwitch.isOn)"
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: newSwitch.bottomAnchor, constant: 8),
            label.centerXAnchor.constraint(equalTo: newSwitch.centerXAnchor)
        ])
    }
    
    @objc
    func switchStateChanged(_ sender: MKSwitch) {
        self.newSwitchStatusLabel?.text = "\(sender.isOn)"
    }

}

