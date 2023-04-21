//
//  TransitionViewController.swift
//  Transition-Demo
//
//  Created by Seb Vidal on 21/04/2023.
//

import UIKit

class TransitionViewController: UIViewController {
    // MARK: - Private Properties
    private var displayCornerRadius: CGFloat {
        return UIScreen.main.value(forKey: "_displayCornerRadius") as! CGFloat
    }
    
    private var firstViewController: UIViewController
    
    private var secondViewController: UIViewController
    
    // MARK: - init(from:to:)
    init(from firstViewController: UIViewController, to secondViewController: UIViewController) {
        self.firstViewController = firstViewController
        self.secondViewController = secondViewController
        super.init(nibName: nil, bundle: nil)
        setupViewController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewController() {
        view.backgroundColor = .black
    }
    
    // MARK: - viewWillAppear(_:)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupFirstViewController()
        setupSecondViewController()
    }
    
    private func setupFirstViewController() {
        addChild(firstViewController)
        firstViewController.view.frame = view.frame
        view.addSubview(firstViewController.view)
        firstViewController.didMove(toParent: self)
        firstViewController.view.layer.cornerCurve = .continuous
        firstViewController.view.layer.cornerRadius = displayCornerRadius
    }
    
    private func setupSecondViewController() {
        addChild(secondViewController)
        
        let frame = view.frame
        let x = frame.maxX
        let y = frame.minY
        let width = frame.width
        let height = frame.height
        secondViewController.view.frame = CGRect(x: x, y: y, width: width, height: height)
        secondViewController.view.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        secondViewController.view.layer.cornerCurve = .continuous
        secondViewController.view.layer.cornerRadius = displayCornerRadius
        view.addSubview(secondViewController.view)
        secondViewController.didMove(toParent: self)
    }
    
    // MARK: - viewDidAppear()
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) { [unowned self] in
            firstViewController.view.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseInOut) { [unowned self] in
            let frame = firstViewController.view.frame
            let x = -frame.maxX
            let y = frame.minY
            let width = frame.width
            let height = frame.height
            firstViewController.view.frame = CGRect(x: x, y: y, width: width, height: height)
            secondViewController.view.frame = frame
        } completion: { [unowned self] _ in
            secondViewController.willMove(toParent: nil)
            secondViewController.view.removeFromSuperview()
            secondViewController.removeFromParent()
            view.window?.rootViewController = secondViewController
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.3, options: .curveEaseInOut) { [unowned self] in
            secondViewController.view.transform = .identity
        }
    }
}
