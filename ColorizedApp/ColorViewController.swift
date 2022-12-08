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
        setToolbar()
        
        colorView.layer.cornerRadius = 10
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
        let ciColor = CIColor(color: backgroundColor)

        setSliders(with: ciColor)
        setLabels(with: ciColor)
        setTextFields(with: ciColor)
    }
    
    func setSliders(with color: CIColor) {
        redSlider.value = Float(color.red)
        greenSlider.value = Float(color.green)
        blueSlider.value = Float(color.blue)
    }
    
    func setLabels(with color: CIColor) {
        redLabel.text = String(format: "%.2f", Float(color.red))
        greenLabel.text = String(format: "%.2f", Float(color.green))
        blueLabel.text = String(format: "%.2f", Float(color.blue))
    }
    
    func setTextFields(with color: CIColor) {
        redTextField.text = String(format: "%.2f", Float(color.red))
        greenTextField.text = String(format: "%.2f", Float(color.green))
        blueTextField.text = String(format: "%.2f", Float(color.blue))
    }
    
    func setToolbar() {
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil,
                                            action: nil)
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .plain,
                                         target: target,
                                         action: #selector(tapDone))
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        
        redTextField.inputAccessoryView = toolBar
        greenTextField.inputAccessoryView = toolBar
        blueTextField.inputAccessoryView = toolBar
    }
    
    @objc func tapDone() {
        view.endEditing(true)
    }
    
    func setParametersByTextField(numberValue: Float, slider: UISlider, label: UILabel) {
        slider.value = numberValue
        label.text = String(format: "%.2f", numberValue)
        setColor()
    }
    
 
}

// MARK: - UITextFieldDelegate
extension ColorViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let newValue = textField.text else { return }
        guard let numberValue = Float(newValue) else {
           
            return }
        
        if textField == redTextField {
            setParametersByTextField(numberValue: numberValue, slider: redSlider, label: redLabel)
        } else if textField == greenTextField {
            setParametersByTextField(numberValue: numberValue, slider: greenSlider, label: greenLabel)
        } else {
            setParametersByTextField(numberValue: numberValue, slider: blueSlider, label: blueLabel)
        }
    }
}
