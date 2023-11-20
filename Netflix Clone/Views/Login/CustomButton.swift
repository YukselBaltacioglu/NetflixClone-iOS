//
//  CustomButton.swift
//  Netflix Clone
//
//  Created by Yüksel Baltacıoğlu on 17.11.2023.
//

import UIKit

class CustomButton: UIButton {

    
    enum FontSize {
        case signIn
        case register
        case remember
    }
    
    init(title: String, hasBackground: Bool = false, fontSize: FontSize) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = 7
        self.layer.masksToBounds = true
        self.backgroundColor = hasBackground ? .red : .clear
        
        switch fontSize {
        case .signIn:
            self.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
           
        case .register:
            self.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        case .remember:
            self.setImage(UIImage(systemName: "square"), for: .normal)
            self.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
            self.tintColor = .gray
            self.setTitleColor(.gray, for: .normal)
            self.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
            
        }
        
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
