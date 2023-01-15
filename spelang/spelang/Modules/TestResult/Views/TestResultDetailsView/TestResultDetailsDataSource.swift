//
//  TestResultDetailsDataSource.swift
//  spelang
//
//  Created by Luka Bokarica on 15.01.2023..
//

import Foundation
import UIKit

final class TestResultDetailsDataSource: NSObject {
    
    var items: [TestQuestionResultCellViewModel] = [TestQuestionResultCellViewModel(word: "pas", answer: "dog", correct: "dog", isAnswerCorrect: true),
                                                    TestQuestionResultCellViewModel(word: "mačka", answer: "cat", correct: "cat", isAnswerCorrect: true),
                                                    TestQuestionResultCellViewModel(word: "kit", answer: nil, correct: "whale", isAnswerCorrect: false),
                                                    TestQuestionResultCellViewModel(word: "orao", answer: "igle", correct: "eagle", isAnswerCorrect: false),
                                                    TestQuestionResultCellViewModel(word: "ptica", answer: "bird", correct: "bird", isAnswerCorrect: true),TestQuestionResultCellViewModel(word: "pas", answer: "dog", correct: "dog", isAnswerCorrect: true),
                                                    TestQuestionResultCellViewModel(word: "mačka", answer: "cat", correct: "cat", isAnswerCorrect: true),
                                                    TestQuestionResultCellViewModel(word: "kit", answer: nil, correct: "whale", isAnswerCorrect: false),
                                                    TestQuestionResultCellViewModel(word: "orao", answer: "igle", correct: "eagle", isAnswerCorrect: false),
                                                    TestQuestionResultCellViewModel(word: "ptica", answer: "bird", correct: "bird", isAnswerCorrect: true),TestQuestionResultCellViewModel(word: "pas", answer: "dog", correct: "dog", isAnswerCorrect: true),
                                                    TestQuestionResultCellViewModel(word: "mačka", answer: "cat", correct: "cat", isAnswerCorrect: true),
                                                    TestQuestionResultCellViewModel(word: "kit", answer: nil, correct: "whale", isAnswerCorrect: false),
                                                    TestQuestionResultCellViewModel(word: "orao", answer: "igle", correct: "eagle", isAnswerCorrect: false),
                                                    TestQuestionResultCellViewModel(word: "ptica", answer: "bird", correct: "bird", isAnswerCorrect: true),TestQuestionResultCellViewModel(word: "pas", answer: "dog", correct: "dog", isAnswerCorrect: true),
                                                    TestQuestionResultCellViewModel(word: "mačka", answer: "cat", correct: "cat", isAnswerCorrect: true),
                                                    TestQuestionResultCellViewModel(word: "kit", answer: nil, correct: "whale", isAnswerCorrect: false),
                                                    TestQuestionResultCellViewModel(word: "orao", answer: "igle", correct: "eagle", isAnswerCorrect: false),
                                                    TestQuestionResultCellViewModel(word: "ptica", answer: "bird", correct: "bird", isAnswerCorrect: true)]
}

extension TestResultDetailsDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TestQuestionResultCell = tableView.dequeueCellAtIndexPath(indexPath: indexPath)
        cell.updateUI(with: items[indexPath.row])
        
        return cell
    }
}
