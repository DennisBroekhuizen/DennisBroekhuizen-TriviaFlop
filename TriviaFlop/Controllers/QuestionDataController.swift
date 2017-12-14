//
//  QuestionDataController.swift
//  TriviaFlop
//
//  Created by Dennis Broekhuizen on 10-12-17.
//  Copyright © 2017 Dennis Broekhuizen. All rights reserved.
//

import Foundation

// Controller to retrieve questions from trivia api.
class QuestionDataController {
    func fetchQuestions(completion: @escaping (Questions?) -> Void) {
        let url = URL(string: "https://opentdb.com/api.php?amount=10&category=21&type=multiple")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let questions = try? jsonDecoder.decode(Questions.self, from: data) {
                completion(questions)
            } else {
                completion(nil)
                return
            }
        }
        task.resume()
    }
}
