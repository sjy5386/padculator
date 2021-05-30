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
    
    @IBOutlet weak var expressionTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var historyTableView: UITableView!
    var historyGroup: HistoryGroup!
}

extension ViewController {
    @IBAction func resultButton(_ sender: UIButton) {
        let expression = expressionTextField.text!
        if expression.count > 0 && brackets == 0 && (expression.last!.isNumber || expression.last == ")") {
            let result = calculate(expression: expression)!
            let r = doubleToString(result)
            expressionTextField.text = r
            resultLabel.text = r
            addHistory(history: History(expression: expression, result: result))
            completed = true
        } else {
            let alertController = UIAlertController(title: "Error!", message: "Invalid expression.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    }
}

extension ViewController {
    @IBAction func button0(_ sender: UIButton) {
        appendExpression(c: "0")
    }
    
    @IBAction func button1(_ sender: UIButton) {
        appendExpression(c: "1")
    }
    
    @IBAction func button2(_ sender: UIButton) {
        appendExpression(c: "2")
    }
    
    @IBAction func button3(_ sender: UIButton) {
        appendExpression(c: "3")
    }
    
    @IBAction func button4(_ sender: UIButton) {
        appendExpression(c: "4")
    }
    
    @IBAction func button5(_ sender: UIButton) {
        appendExpression(c: "5")
    }
    
    @IBAction func button6(_ sender: UIButton) {
        appendExpression(c: "6")
    }
    
    @IBAction func button7(_ sender: UIButton) {
        appendExpression(c: "7")
    }
    
    @IBAction func button8(_ sender: UIButton) {
        appendExpression(c: "8")
    }
    
    @IBAction func button9(_ sender: UIButton) {
        appendExpression(c: "9")
    }
}

extension ViewController {
    @IBAction func backspaceButton(_ sender: UIButton) {
        if expressionTextField.text!.count > 0 {
            let last = expressionTextField.text?.remove(at: expressionTextField.text!.index(before: expressionTextField.text!.endIndex))
            if last == "(" {
                brackets -= 1
            } else if last == ")" {
                brackets += 1
            }
        }
    }
    
    @IBAction func clearButton(_ sender: UIButton) {
        expressionTextField.text?.removeAll()
        resultLabel.text = "0"
        brackets = 0
    }
}

extension ViewController {
    @IBAction func plusButton(_ sender: UIButton) {
        expressionTextField.text?.append("+")
    }
    
    @IBAction func minusButton(_ sender: UIButton) {
        expressionTextField.text?.append("-")
    }
    
    @IBAction func timesButton(_ sender: UIButton) {
        expressionTextField.text?.append("*")
    }
    
    @IBAction func divideButton(_ sender: UIButton) {
        expressionTextField.text?.append("/")
    }
    
    @IBAction func pointButton(_ sender: UIButton) {
        expressionTextField.text?.append(".")
    }
    
    @IBAction func powButton(_ sender: UIButton) {
        expressionTextField.text?.append("^")
    }
    
    @IBAction func bracketButton(_ sender: UIButton) {
        if expressionTextField.text!.count > 0 && brackets > 0  && (expressionTextField.text!.last!.isNumber || expressionTextField.text?.last == ")") {
            expressionTextField.text?.append(")")
            brackets -= 1
        } else {
            if expressionTextField.text!.count > 0 && (expressionTextField.text!.last!.isNumber || expressionTextField.text?.last == ")") {
                expressionTextField.text?.append("*")
            }
            expressionTextField.text?.append("(")
            brackets += 1
        }
    }
    
    @IBAction func plusMinusButton(_ sender: UIButton) {
        if expressionTextField.text!.count > 0 && (expressionTextField.text!.last!.isNumber || expressionTextField.text?.last == ")") {
            expressionTextField.text?.append("*(-1)")
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
    func appendExpression(c: Character) {
        if completed && c.isNumber && (expressionTextField.text == resultLabel.text) {
            expressionTextField.text?.removeAll()
            completed = false
        }
        expressionTextField.text?.append(c)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyGroup.histories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell")!
        
        let history = historyGroup.histories[indexPath.row]
        cell.textLabel?.text = history.expression
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
