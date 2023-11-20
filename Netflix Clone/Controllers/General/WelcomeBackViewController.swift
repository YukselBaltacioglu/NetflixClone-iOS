//
//  WelcomeBackViewController.swift
//  Netflix Clone
//
//  Created by Yüksel Baltacıoğlu on 19.11.2023.
//

import UIKit

class WelcomeBackViewController: UIViewController {

    private let welcomeLabel: UILabel = {
        let labelView = UILabel()
        labelView.font = .systemFont(ofSize: 30, weight: .bold)
        labelView.text = "WELCOME BACK"
        labelView.textColor = .red
        labelView.layer.masksToBounds = true
        labelView.translatesAutoresizingMaskIntoConstraints = false
        
        return labelView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confLabel()
        print("CCCCCC")
        
    }
    
    func confLabel() {
        
        self.view.addSubview(welcomeLabel)
        
        let labelConstraints = [
            welcomeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            welcomeLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 300)
        ]
        
        NSLayoutConstraint.activate(labelConstraints)
    }


}
