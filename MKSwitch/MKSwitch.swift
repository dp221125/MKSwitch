//
//  MKSwitch.swift
//  MKSwitch
//
//  Created by Seokho on 2020/01/29.
//  Copyright © 2020 Seokho. All rights reserved.
//

import UIKit

class MKSwitch: UIControl {
    
    private weak var thumb: UIButton?
    private weak var track: UIView?
    
    private(set) var isOn: Bool = false {
        didSet {
            if oldValue != isOn {
                self.sendActions(for: .valueChanged)
            }
        }
    }
    
    private var thumbLeftAnchor: NSLayoutConstraint? {
        didSet {
            self.thumbLeftAnchor?.isActive = true
        }
        willSet {
            self.thumbLeftAnchor?.isActive = false
        }
    }
    
    var trackOnColor: UIColor = .systemGray {
        didSet {
            self.changeColor()
        }
    }
    
    var thumbOnColor: UIColor = .systemPink {
        didSet {
            self.changeColor()
        }
    }
    
    var thumbOffColor: UIColor = .white {
        didSet {
            self.changeColor()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 51),
            self.heightAnchor.constraint(equalToConstant: 31)
        ])
        
        let track = UIView()
        track.layer.shadowOpacity = 0.5
        track.layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
        track.layer.shadowColor = UIColor.black.cgColor
        track.layer.shadowRadius = 0.5
        self.addSubview(track)
        self.track = track
        track.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            track.widthAnchor.constraint(equalToConstant: 44),
            track.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.24),
            track.centerXAnchor.constraint(equalTo: centerXAnchor),
            track.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        let thumb = UIButton()
        thumb.layer.shadowOpacity = 0.5
        thumb.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        thumb.layer.shadowColor = UIColor.black.cgColor
        thumb.layer.shadowRadius = 1.0
        thumb.addTarget(self, action: #selector(MKSwitch.buttonPressed), for: .touchUpInside)
        self.thumb = thumb
        self.addSubview(thumb)
        thumb.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thumb.heightAnchor.constraint(equalTo: self.heightAnchor),
            thumb.widthAnchor.constraint(equalTo: thumb.heightAnchor),
            thumb.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        self.thumbLeftAnchor = thumb.leftAnchor.constraint(equalTo: self.leftAnchor)
        self.changeColor()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let track = self.track, let thumb = self.thumb else { return }
        track.layer.cornerRadius = track.bounds.height * 0.48
        thumb.layer.cornerRadius = thumb.bounds.height * 0.5
    }

    @objc
    private func buttonPressed() {
        self.isOn.toggle()
        self.setThumbPosition(isAnimation: true)
    }
        
    private func setThumbPosition(isAnimation: Bool = true) {
        if isAnimation {
            UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseInOut, animations: {
                self.moveThumb()
            })
        } else {
            self.moveThumb()
        }
    }
    
    private func moveThumb() {
        guard let thumb = self.thumb else { return }
        if self.isOn {
            self.thumbLeftAnchor = thumb.rightAnchor.constraint(equalTo: self.rightAnchor)
        } else {
            self.thumbLeftAnchor = thumb.leftAnchor.constraint(equalTo: self.leftAnchor)
        }
        
        self.changeColor()
        self.layoutIfNeeded()
    }

    private func changeColor() {
        track?.backgroundColor = self.trackOnColor
        thumb?.backgroundColor = isOn ? self.thumbOnColor : self.thumbOffColor
    }
    
    func setIsOn(isOn: Bool, isAnimation: Bool = false) {
        self.isOn = isOn
        self.setThumbPosition(isAnimation: isAnimation)
    }
}
