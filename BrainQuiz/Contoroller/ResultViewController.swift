//
//  ResultViewController.swift
//  BrainQuiz
//
//  Created by Евгений Лянкэ on 16.02.2022.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    var score : String?
    var main = ViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = "Your score is:\(score!)"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func playAgainPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: { [self] in
            self.main.viewDidLoad()
        })
    }
    
}
