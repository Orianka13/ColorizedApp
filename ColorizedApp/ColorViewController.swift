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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        getColor()
        setColor()
        
        colorView.layer.cornerRadius = 10
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    
    @IBAction func redSliderAction() {
        setValue(for: redLabel)
        setValue(for: redTextField)
        setColor()
    }
    
    @IBAction func greenSliderAction() {
        setValue(for: greenLabel)
        setValue(for: greenTextField)
        setColor()
    }
    
    @IBAction func blueSliderAction() {
        setValue(for: blueLabel)
        setValue(for: blueTextField)
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
        let ciColor = CIColor(color: backgroundColor)
        
        setSliders(with: ciColor)
        
        setValue(for: redLabel, greenLabel, blueLabel)
        setValue(for: redTextField, greenTextField, blueTextField)
    }
    
    func setSliders(with color: CIColor) {
        redSlider.setValue(Float(color.red), animated: true)
        greenSlider.setValue(Float(color.green), animated: true)
        blueSlider.setValue(Float(color.blue), animated: true)
    }
    
    func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redLabel: label.text = String(format: "%.2f", redSlider.value)
            case greenLabel: label.text = String(format: "%.2f", greenSlider.value)
            default: label.text = String(format: "%.2f", blueSlider.value)
            }
        }
    }
    
    func setValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTextField: textField.text = String(format: "%.2f", redSlider.value)
            case greenTextField: textField.text = String(format: "%.2f", greenSlider.value)
            default: textField.text = String(format: "%.2f", blueSlider.value)
            }
        }
    }
    
    @objc func tapDone() {
        view.endEditing(true)
    }
    
    func setParametersByTextField(numberValue: Float, slider: UISlider, label: UILabel) {
        slider.setValue(numberValue, animated: true)
        setValue(for: label)
        setColor()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Error",
                                      message: "Enter correct value",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension ColorViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let newValue = textField.text else { return }
        guard let numberValue = Float(newValue), numberValue <= 1, numberValue >= 0 else {
            showAlert()
            getColor()
            return
        }
        
        if textField == redTextField {
            setParametersByTextField(numberValue: numberValue, slider: redSlider, label: redLabel)
        } else if textField == greenTextField {
            setParametersByTextField(numberValue: numberValue, slider: greenSlider, label: greenLabel)
        } else {
            setParametersByTextField(numberValue: numberValue, slider: blueSlider, label: blueLabel)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        textField.inputAccessoryView = toolBar
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil,
                                            action: nil)
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .done,
                                         target: target,
                                         action: #selector(tapDone))
        
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
    }
}
