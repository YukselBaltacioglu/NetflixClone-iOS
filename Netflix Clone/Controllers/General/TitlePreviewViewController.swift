//
//  TitlePreviewViewController.swift
//  Netflix Clone
//
//  Created by Yüksel Baltacıoğlu on 13.11.2023.
//

import UIKit
import WebKit

class TitlePreviewViewController: UIViewController {

    private let webView: WKWebView =  {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "Harry Potter"
        return label
    }()
    
    private let overviewTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "This is the best movie ever."
        
        return label
    }()
    
    public let addWatchlistButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.setImage(UIImage(systemName: "checkmark"), for: .selected)
        button.backgroundColor = .red
        button.imageView?.tintColor = .white
        button.setTitle(" My List", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        view.addSubview(titleLabel)
        view.addSubview(overviewTitleLabel)
        view.addSubview(addWatchlistButton)
        
        self.addWatchlistButton.addTarget(self, action: #selector(addWatchlistButtonTapped), for: .touchUpInside)
        
        configureConstraints()
        
        
    }
    
    @objc private func addWatchlistButtonTapped(){
        self.addWatchlistButton.isSelected.toggle()
    }

    func configureConstraints() {
        let webViewConstraints = [
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 250)
        ]
        
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ]
        
        let overviewLabelConstraints = [
            overviewTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            overviewTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overviewTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        let watchlistButtonConstraints = [
            addWatchlistButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addWatchlistButton.topAnchor.constraint(equalTo: overviewTitleLabel.bottomAnchor, constant: 25),
            addWatchlistButton.widthAnchor.constraint(equalToConstant: 110),
            addWatchlistButton.heightAnchor.constraint(equalToConstant: 45)
        ]
        
        NSLayoutConstraint.activate(webViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(overviewLabelConstraints)
        NSLayoutConstraint.activate(watchlistButtonConstraints)
    }
    
    func configure(with model: TitlePreviewViewModel){
        
        titleLabel.text = model.title
        overviewTitleLabel.text = model.titleOverview
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId)") else {return}
        
        webView.load(URLRequest(url: url))
    }
}
