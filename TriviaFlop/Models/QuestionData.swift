//
//  QuestionData.swift
//  TriviaFlop
//
//  Created by Dennis Broekhuizen on 10-12-17.
//  Copyright © 2017 Dennis Broekhuizen. All rights reserved.
//

import Foundation

struct Questions: Codable {
    let question: [Question]
    
    enum CodingKeys: String, CodingKey {
        case question = "results"
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.question = try valueContainer.decode([Question].self, forKey: CodingKeys.question)
    }
    
}

struct Question: Codable {
    let text: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    let difficulty: String
    
    enum CodingKeys: String, CodingKey {
        case text = "question"
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
        case difficulty = "difficulty"
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.text = try valueContainer.decode(String.self, forKey: CodingKeys.text)
        self.correctAnswer = try valueContainer.decode(String.self, forKey: CodingKeys.correctAnswer)
        self.incorrectAnswers = try valueContainer.decode([String].self, forKey: CodingKeys.incorrectAnswers)
        self.difficulty = try valueContainer.decode(String.self, forKey: CodingKeys.difficulty)
    }
    
}
