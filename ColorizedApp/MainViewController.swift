//
//  MainViewController.swift
//  ColorizedApp
//
//  Created by Олеся Егорова on 07.12.2022.
//

import UIKit

protocol ColorViewControllerDelegate {
    func setNewBackground(color: UIColor)
}

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let colorVC = segue.destination as? ColorViewController {
            colorVC.backgroundColor = view.backgroundColor
            colorVC.delegate = self
        }
    }
}

// MARK: - ColorViewControllerDelegate
extension MainViewController: ColorViewControllerDelegate {
    func setNewBackground(color: UIColor) {
        view.backgroundColor = color
    }
}
