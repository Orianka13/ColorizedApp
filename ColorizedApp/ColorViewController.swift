//
//  ColorViewController.swift
//  ColorizedApp
//
//  Created by Олеся Егорова on 01.11.2022.
//

import UIKit

class ColorViewController: UIViewController {
    
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    var backgroundColor: UIColor!
    
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getColor()
        
        setColor()
        
        colorView.layer.cornerRadius = 10
    }
    
    
    @IBAction func redSliderAction() {
        redLabel.text = String(format: "%.2f", redSlider.value)
        setColor()
    }
    
    @IBAction func greenSliderAction() {
        greenLabel.text = String(format: "%.2f", greenSlider.value)
        setColor()
    }
    
    @IBAction func blueSliderAction() {
        blueLabel.text = String(format: "%.2f", blueSlider.value)
        setColor()
    }
    
    private func setColor() {
        backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                  green: CGFloat(greenSlider.value),
                                  blue:  CGFloat(blueSlider.value),
                                  alpha: 1)
        colorView.backgroundColor = backgroundColor
    }
    
    private func getColor() {
        
        backgroundColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        redSlider.value = Float(red)
        greenSlider.value = Float(green)
        blueSlider.value = Float(blue)
        
        redLabel.text = String(format: "%.2f", redSlider.value)
        greenLabel.text = String(format: "%.2f", greenSlider.value)
        blueLabel.text = String(format: "%.2f", blueSlider.value)
    }
}

