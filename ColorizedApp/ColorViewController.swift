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
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    var backgroundColor: UIColor!
    var delegate: ColorViewControllerDelegate!
    
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        getColor()
        setColor()
        colorView.layer.cornerRadius = 10
        setToolbar()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesBegan(touches, with: event)
            view.endEditing(true)
        }

    
    
    @IBAction func redSliderAction() {
        redLabel.text = String(format: "%.2f", redSlider.value)
        redTextField.text = String(format: "%.2f", redSlider.value)
        setColor()
    }
    
    @IBAction func greenSliderAction() {
        greenLabel.text = String(format: "%.2f", greenSlider.value)
        greenTextField.text = String(format: "%.2f", greenSlider.value)
        setColor()
    }
    
    @IBAction func blueSliderAction() {
        blueLabel.text = String(format: "%.2f", blueSlider.value)
        blueTextField.text = String(format: "%.2f", blueSlider.value)
        setColor()
    }
    @IBAction func doneButtonPressed() {
        delegate.setNewBackground(color: backgroundColor)
        dismiss(animated: true)
    }
}

//MARK: - Private methods
private extension ColorViewController {
    
    func setColor() {
        backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                  green: CGFloat(greenSlider.value),
                                  blue:  CGFloat(blueSlider.value),
                                  alpha: 1)
        colorView.backgroundColor = backgroundColor
    }
    
    func getColor() {
        
        backgroundColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        redSlider.value = Float(red)
        greenSlider.value = Float(green)
        blueSlider.value = Float(blue)
        
        redLabel.text = String(format: "%.2f", redSlider.value)
        greenLabel.text = String(format: "%.2f", greenSlider.value)
        blueLabel.text = String(format: "%.2f", blueSlider.value)
        
        redTextField.text = String(format: "%.2f", redSlider.value)
        greenTextField.text = String(format: "%.2f", greenSlider.value)
        blueTextField.text = String(format: "%.2f", blueSlider.value)
    }
    
    func setToolbar() {
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: #selector(tapDone))
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        redTextField.inputAccessoryView = toolBar
        greenTextField.inputAccessoryView = toolBar
        blueTextField.inputAccessoryView = toolBar
    }
    
    @objc func tapDone() {
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate
extension ColorViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let newValue = textField.text else { return }
        guard let numberValue = Float(newValue) else { return }
        
        if textField == redTextField {
            redSlider.value = numberValue
            redLabel.text = String(format: "%.2f", numberValue)
            setColor()
            
        } else if textField == greenTextField {
            greenSlider.value = numberValue
            greenLabel.text = String(format: "%.2f", numberValue)
            setColor()
            
        } else {
            blueSlider.value = numberValue
            blueLabel.text = String(format: "%.2f", numberValue)
            setColor()
        }
    }
}
