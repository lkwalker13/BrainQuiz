//
//  ViewController.swift
//  BrainQuiz
//
//  Created by Евгений Лянкэ on 15.02.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var forthButtonLabel: UIButton!
    @IBOutlet weak var thirdButtonLabel: UIButton!
    @IBOutlet weak var secondButtonLabel: UIButton!
    @IBOutlet weak var firstButtonLabel: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    var buttonsArray = [UIButton].self()
    var operations = ["+","-","*"]
    var result = 0
    var timer = Timer()
    var i = 20
    var scoreCounter = 0
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButtonsArray(button: firstButtonLabel,secondButtonLabel,thirdButtonLabel,forthButtonLabel)
        getNumbers()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
       
    }
    
    func getNumbers() {
      let  a = Int.random(in: 0...100)
      let b = Int.random(in: 0...100)
      let arrayIndex = Int.random(in: 0...2)
        switch operations[arrayIndex] {
        case "+": result = a+b
        case "-":result = a-b
        default:result = a*b
        
        }
        questionLabel.text = "\(a)\(operations[arrayIndex])\(b)= ???"
        let randomAnswer = Int.random(in: 0...3)
        
        for i in 0...3{
            if i == randomAnswer {
                buttonsArray[i].setTitle(String(result), for: .normal)
            }else{
                buttonsArray[i].setTitle(String(Int.random(in: 0...100)), for: .normal)
            }
        }
       
    }
    
    func addButtonsArray(button:UIButton...){
        for i in 0...3 {
            buttonsArray.append(button[i])
        }
    }
    
    func checkRightAnswer(button:UIButton) {
        let color = button.backgroundColor
        if button.currentTitle == String(result){
            scoreCounter+=1
            scoreLabel.text = String(format: "%.2d", scoreCounter)
            button.backgroundColor = UIColor.green
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                button.backgroundColor = color
            }
        }else {
            button.backgroundColor = UIColor.red
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                button.backgroundColor = color
            }
        }
        
    }
    
    @objc func updateCounter(){
        if i >= 0 {
            if i<5{
                timerLabel.textColor=UIColor.red
            }
         timerLabel.text = stringTime(second: i)
         i-=1
        }else{
            timer.invalidate()
            timerLabel.textColor=UIColor.black
            timerLabel.text = "00:20"
            self.performSegue(withIdentifier: "goToResult", sender: self)
        }
    }
   
    func stringTime(second:Int) -> String{
        var time = "00:"
        time+=String(format: "%.2d", second)
        return time
    }
    
    
    @IBAction func answerPressed(_ sender: UIButton) {
        checkRightAnswer(button: sender)
        getNumbers()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destination = segue.destination as! ResultViewController
            destination.score = String(scoreCounter)
        }
    }
    
}

