//
//  MainViewController.swift
//  ColorizedApp
//
//  Created by Олеся Егорова on 07.12.2022.
//

import UIKit



class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let colorVC = segue.destination as? ColorViewController {
            colorVC.backgroundColor = view.backgroundColor
        }
    }
}
