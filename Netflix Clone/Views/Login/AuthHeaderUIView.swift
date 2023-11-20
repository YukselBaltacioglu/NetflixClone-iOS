//
//  AuthHeaderUIView.swift
//  Netflix Clone
//
//  Created by Yüksel Baltacıoğlu on 16.11.2023.
//

import UIKit

class AuthHeaderUIView: UIView {

    private let logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "580b57fcd9996e24bc43c529")
        
        return imageView
    }()
    
    private let signLabel: UILabel = {
        let labelView = UILabel()
        labelView.text = "Sign In"
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.font = .systemFont(ofSize: 30, weight: .bold)
        labelView.textColor = .white
        
        return labelView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubview(logoView)
        addSubview(signLabel)
        applyConstraints()
    }
    
   
    
    private func applyConstraints() {
        let logoConstraints = [
            logoView.leadingAnchor.constraint(equalTo: leadingAnchor),
            logoView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 16),
            logoView.widthAnchor.constraint(equalToConstant: 200),
            logoView.heightAnchor.constraint(equalToConstant: 100)
        ]
        
        let labelConstraints = [
            signLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 17),
            signLabel.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 50)
        ]
        
        NSLayoutConstraint.activate(logoConstraints)
        NSLayoutConstraint.activate(labelConstraints)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
