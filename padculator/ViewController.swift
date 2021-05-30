//
//  ViewController.swift
//  padculator
//
//  Created by mac024 on 2021/05/16.
//

import UIKit

class ViewController: UIViewController {
    var brackets: Int = 0
    var completed: Bool = true
    
    @IBOutlet weak var equationTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var historyTableView: UITableView!
    var historyGroup: HistoryGroup!
}

extension ViewController {
    @IBAction func resultButton(_ sender: UIButton) {
        let equation = equationTextField.text!
        if equation.count > 0 && brackets == 0 && (equation.last!.isNumber || equation.last == ")") {
            let result = calculate(equation: equation)!
            let r = doubleToString(result)
            equationTextField.text = r
            resultLabel.text = r
            addHistory(history: History(equation: equation, result: result))
            completed = true
        } else {
            let alertController = UIAlertController(title: "Error!", message: "Invalid equation.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    }
}

extension ViewController {
    @IBAction func button0(_ sender: UIButton) {
        appendEquation(c: "0")
    }
    
    @IBAction func button1(_ sender: UIButton) {
        appendEquation(c: "1")
    }
    
    @IBAction func button2(_ sender: UIButton) {
        appendEquation(c: "2")
    }
    
    @IBAction func button3(_ sender: UIButton) {
        appendEquation(c: "3")
    }
    
    @IBAction func button4(_ sender: UIButton) {
        appendEquation(c: "4")
    }
    
    @IBAction func button5(_ sender: UIButton) {
        appendEquation(c: "5")
    }
    
    @IBAction func button6(_ sender: UIButton) {
        appendEquation(c: "6")
    }
    
    @IBAction func button7(_ sender: UIButton) {
        appendEquation(c: "7")
    }
    
    @IBAction func button8(_ sender: UIButton) {
        appendEquation(c: "8")
    }
    
    @IBAction func button9(_ sender: UIButton) {
        appendEquation(c: "9")
    }
}

extension ViewController {
    @IBAction func backspaceButton(_ sender: UIButton) {
        if equationTextField.text!.count > 0 {
            let last = equationTextField.text?.remove(at: equationTextField.text!.index(before: equationTextField.text!.endIndex))
            if last == "(" {
                brackets -= 1
            } else if last == ")" {
                brackets += 1
            }
        }
    }
    
    @IBAction func clearButton(_ sender: UIButton) {
        equationTextField.text?.removeAll()
        resultLabel.text = "0"
        brackets = 0
    }
}

extension ViewController {
    @IBAction func plusButton(_ sender: UIButton) {
        equationTextField.text?.append("+")
    }
    
    @IBAction func minusButton(_ sender: UIButton) {
        equationTextField.text?.append("-")
    }
    
    @IBAction func timesButton(_ sender: UIButton) {
        equationTextField.text?.append("*")
    }
    
    @IBAction func divideButton(_ sender: UIButton) {
        equationTextField.text?.append("/")
    }
    
    @IBAction func pointButton(_ sender: UIButton) {
        equationTextField.text?.append(".")
    }
    
    @IBAction func powButton(_ sender: UIButton) {
        equationTextField.text?.append("^")
    }
    
    @IBAction func bracketButton(_ sender: UIButton) {
        if equationTextField.text!.count > 0 && brackets > 0  && (equationTextField.text!.last!.isNumber || equationTextField.text?.last == ")") {
            equationTextField.text?.append(")")
            brackets -= 1
        } else {
            if equationTextField.text!.count > 0 && (equationTextField.text!.last!.isNumber || equationTextField.text?.last == ")") {
                equationTextField.text?.append("*")
            }
            equationTextField.text?.append("(")
            brackets += 1
        }
    }
    
    @IBAction func plusMinusButton(_ sender: UIButton) {
        if equationTextField.text!.count > 0 && (equationTextField.text!.last!.isNumber || equationTextField.text?.last == ")") {
            equationTextField.text?.append("*(-1)")
        }
    }
}

extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        historyGroup = HistoryGroup()
        historyTableView.dataSource = self
    }
}

extension ViewController {
    func appendEquation(c: Character) {
        if completed && c.isNumber && (equationTextField.text == resultLabel.text) {
            equationTextField.text?.removeAll()
            completed = false
        }
        equationTextField.text?.append(c)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyGroup.histories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell")!
        
        let history = historyGroup.histories[indexPath.row]
        cell.textLabel?.text = history.equation
        cell.detailTextLabel?.text = doubleToString(history.result)
        return cell
    }
}

extension ViewController {
    func addHistory(history: History) {
        historyGroup.addHistory(history: history)
        let indexPath = IndexPath(row: 0, section: 0)
        historyTableView.insertRows(at: [indexPath], with: .automatic)
    }
}
