//
//  ViewController.swift
//  Transition-Demo
//
//  Created by Seb Vidal on 21/04/2023.
//

import UIKit

class ViewController: UIViewController {
    private var transitionButton: UIButton!

    init() {
        super.init(nibName: nil, bundle: nil)
        setupViewController()
        setupTransitionButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewController() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupTransitionButton() {
        transitionButton = UIButton(type: .system)
        transitionButton.configuration = .bordered()
        transitionButton.configuration?.cornerStyle = .capsule
        transitionButton.setTitle("Transition", for: .normal)
        transitionButton.translatesAutoresizingMaskIntoConstraints = false
        transitionButton.addTarget(self, action: #selector(transitionButtonTapped), for: .touchUpInside)
        
        view.addSubview(transitionButton)
        
        NSLayoutConstraint.activate([
            transitionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            transitionButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func transitionButtonTapped(_ sender: UIButton) {
        let sceneDelegate = view.window?.windowScene?.delegate as! SceneDelegate
        sceneDelegate.transition(to: ViewController())
    }
}
