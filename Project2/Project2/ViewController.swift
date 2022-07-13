//
//  ViewController.swift
//  Project2
//
//  Created by Ilija Neskovic on 13.7.22..
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var attemptsLeft: UILabel!
    
    var countries = [String]()
    var score = 0
    var totalQuestions = 0
    
    var correctAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attemptsLeft.text = "Hello there!"
//        self.view.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        countries += ["estonia", "france","germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "us", "uk"]
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1

        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        // MARK: FIX For borders
        button1.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        button2.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        button3.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        askQuestion()
    }
    
    func restartGame(action: UIAlertAction! = nil){
        score = 0
        totalQuestions = 0
        askQuestion()

    }

    func askQuestion(action: UIAlertAction! = nil){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage (named: countries[0]), for: .normal)
        button2.setImage(UIImage (named: countries[1]), for: .normal)
        button3.setImage(UIImage (named: countries[2]), for: .normal)
        
        // MARK: Sets borders and colors to default (gray width : 1)
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1

        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        title = countries[correctAnswer].uppercased() + "  Your score is - \(score)"

    }
    @IBAction func buttonTaped(_ sender: UIButton) {
        attemptsLeft.text = "You have \(10-totalQuestions) flags left to guess"

        if totalQuestions < 10{
            var AnswerString: String
            var UIAlertTitleColor: UIColor?
            if sender.tag == correctAnswer{
                AnswerString = "Correct!"
                UIAlertTitleColor = UIColor.systemBlue
                score += 1

            }else{
                // MARK:  Sets button border to 5 and sets color
                AnswerString = "Wrong! Correct answer is \(correctAnswer)"
                UIAlertTitleColor = UIColor.systemRed
                score -= 1
                print(button1.tag)
                print(correctAnswer)
                if button1.tag == correctAnswer{
                    button1.layer.borderColor = UIColor.green.cgColor
                    button1.layer.borderWidth = 5
                    button2.layer.borderColor = UIColor.red.cgColor
                    button2.layer.borderWidth = 5
                    button3.layer.borderColor = UIColor.red.cgColor
                    button3.layer.borderWidth = 5
                }else if button2.tag == correctAnswer{
                    button2.layer.borderColor = UIColor.green.cgColor
                    button2.layer.borderWidth = 5
                    button1.layer.borderColor = UIColor.red.cgColor
                    button1.layer.borderWidth = 5
                    button3.layer.borderColor = UIColor.red.cgColor
                    button3.layer.borderWidth = 5
                }else if button3.tag == correctAnswer{
                    button3.layer.borderColor = UIColor.green.cgColor
                    button3.layer.borderWidth = 5
                    button2.layer.borderColor = UIColor.red.cgColor
                    button2.layer.borderWidth = 5
                    button1.layer.borderColor = UIColor.red.cgColor
                    button1.layer.borderWidth = 5

                }
            }
            
            let ac = UIAlertController(title: AnswerString, message: "Your score is \(score)", preferredStyle: .alert)
            ac.setValue(NSAttributedString(
                string: AnswerString,
                attributes:
                    [.foregroundColor :UIAlertTitleColor ?? UIColor.blue,
                     .font: UIFont.systemFont(ofSize: 20, weight: .bold
                                             )]),

                        forKey: "attributedTitle")

            ac.addAction(UIAlertAction(title: "Countinue", style: .default, handler: askQuestion))
            present(ac, animated: true)
            totalQuestions+=1
        }else{
            let endAlert = UIAlertController(title: "Finish!", message:  "Your final score is \(score) in total of \(totalQuestions) questions", preferredStyle: .alert)
            endAlert.addAction(UIAlertAction(title: "Try again?", style: .default, handler: restartGame))
            present(endAlert, animated: true)
        }
    }
    
}
