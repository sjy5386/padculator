//
//  ViewController.swift
//  padculator
//
//  Created by mac024 on 2021/05/16.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var equationTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func resultButton(_ sender: UIButton) {
        let equation = equationTextField.text
        let result = calculate(equation: equation!)
        resultLabel.text = String(result!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
