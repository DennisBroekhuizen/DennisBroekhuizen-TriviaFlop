//
//  QuestionViewController.swift
//  TriviaFlop
//
//  Created by Dennis Broekhuizen on 10-12-17.
//  Copyright © 2017 Dennis Broekhuizen. All rights reserved.
//
// Quiz timer by: https://stackoverflow.com/questions/29374553/how-to-make-a-countdown-with-nstimer-on-swift.

import UIKit
import HTMLString
import SwiftySound

// UIButton animations by: http://seanallen.co/posts/uibutton-animations.
extension UIButton {
    
    func pulsate() {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.2
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: "pulse")
    }
    
    func shake() {
        
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.2
        shake.repeatCount = 1
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: "position")
    }
}

class QuestionViewController: UIViewController {
    
    // Outlets.
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var wrongLabel: UILabel!
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    @IBOutlet weak var leftBarButton: UIBarButtonItem!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // Variables and constants.
    var questionIndex = 0
    var score = 0
    var counter = 20
    var questions: [Question] = []
    let questionDataController = QuestionDataController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide correct and wrong label.
        correctLabel.isHidden = true
        wrongLabel.isHidden = true
        singleStackView.isHidden = true
        
        // Update question label while questions are loading
        questionLabel.text = "Loading questions..."
        
        // Retrieve questions from API and update the UI.
        questionDataController.fetchQuestions { (questions) in
            if let questions = questions {
                DispatchQueue.main.async {
                    // Load API info into questions array.
                    self.questions = questions.question
                    
                    // Hide loading elements in view.
                    self.cancelButton.isHidden = true
                    self.activityIndicator.isHidden = true
                    self.singleStackView.isHidden = false
                    
                    // Update UI with first question.
                    self.updateUI()
                    
                    // Start quiztimer.
                    var _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateCounter), userInfo: nil, repeats: true)
                }
            }
        }
    }
    
    @objc func updateCounter() {
        // Update timer when there is time left.
        if counter > -1 {
            self.rightBarButton.title = String(counter) + "\""
            counter -= 1
        }
        
        // Play timer sound when timer has ~10 seconds left.
        if counter == 9 {
            Sound.play(file: "timer.mp3", numberOfLoops: 10)
        }
        
        // Skip to next question when times up.
        if counter == -1 {
            self.rightBarButton.title = ""
            Sound.stop(file: "timer.mp3")
            Sound.play(file: "timeUp.mp3")
            nextQuestion()
        }
    }
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        // Disable buttons until next question is loaded, so user can't switch answers.
        singleButton1.isEnabled = false
        singleButton2.isEnabled = false
        singleButton3.isEnabled = false
        singleButton4.isEnabled = false
        
        // Stop timer sound when button is pressed.
        Sound.stop(file: "timer.mp3")
        
        // Check if chosen answer is correct and update users score.
        if sender.currentTitle! == questions[questionIndex].correctAnswer {
            // Show correct label and play corret sound.
            correctLabel.isHidden = false
            Sound.play(file: "correctAnswer.mp3")
            
            // Shake chosen answer button.
            sender.pulsate()
            
            // Declare difficulty of question and add point coresponding to difficulty.
            let difficulty = questions[questionIndex].difficulty
            switch difficulty {
            case "easy":
                score += 10
            case "medium":
                score += 15
            case "hard":
                score += 20
            default:
                score += 0
            }
        } else {
            // Handle incorrect answer label, sound and button animation.
            wrongLabel.isHidden = false
            Sound.play(file: "wrongAnswer.mp3")
            sender.shake()
        }
        
        // Enable buttons and show next question after delay.
        perform(#selector(enableButtons), with: nil, afterDelay: 1.5)
        perform(#selector(nextQuestion), with: nil, afterDelay: 1.0)
    }
    
    @objc func enableButtons() {
        singleButton1.isEnabled = true
        singleButton2.isEnabled = true
        singleButton3.isEnabled = true
        singleButton4.isEnabled = true
    }
    
    // Show next question if there are any left, esle show result.
    @objc func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }
    
    func updateUI() {
        // Set timer counter back to 20 seconds.
        counter = 20
        
        // Hide correct and wrong label.
        correctLabel.isHidden = true
        wrongLabel.isHidden = true
        
        // Calculate progress and declare next question.
        let totalProgress = Float(questionIndex) / Float(questions.count)
        let currentQuestion = questions[questionIndex]
        
        // Put correct and incorrect answers in array.
        var answers = [currentQuestion.correctAnswer.removingHTMLEntities,
                       currentQuestion.incorrectAnswers[0].removingHTMLEntities,
                       currentQuestion.incorrectAnswers[1].removingHTMLEntities,
                       currentQuestion.incorrectAnswers[2].removingHTMLEntities]
        
        // Shuffle answers by: https://learnappmaking.com/shuffling-array-swift-explained/.
        var randomAnswers = [String]()
        for _ in 0..<answers.count {
            let rand = Int(arc4random_uniform(UInt32(answers.count)))

            randomAnswers.append(answers[rand])

            answers.remove(at: rand)
        }
        
        // Update title, label, buttons and progressview.
        navigationItem.title = "Question \(self.questionIndex+1)"
        self.leftBarButton.title = currentQuestion.difficulty.capitalized
        questionLabel.text = currentQuestion.text.removingHTMLEntities
        singleButton1.setTitle(randomAnswers[0], for: .normal)
        singleButton2.setTitle(randomAnswers[1], for: .normal)
        singleButton3.setTitle(randomAnswers[2], for: .normal)
        singleButton4.setTitle(randomAnswers[3], for: .normal)
        questionProgressView.setProgress(totalProgress, animated:true)
        print(currentQuestion.correctAnswer)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Stop timer sound.
        Sound.stop(file: "timer.mp3")
        Sound.stop(file: "timeUp.mp3")

        // Set timer to value that can't let the timer run again.
        counter = -2
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender:
        Any?) {
        // Go to next screen with totalscore.
        if segue.identifier == "ResultsSegue" {
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.totalScore = score
        }
    }
}
