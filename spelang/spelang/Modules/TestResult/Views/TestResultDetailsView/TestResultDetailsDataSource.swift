//
//  TestResultDetailsDataSource.swift
//  spelang
//
//  Created by Luka Bokarica on 15.01.2023..
//

import Foundation
import UIKit

final class TestResultDetailsDataSource: NSObject {
    
    var items: [TestQuestionResultCellViewModel] = []
    
    init(from context: TestResultContext) {
        super.init()
        self.fillUpItems(from: context)
    }
    
    private func fillUpItems(from context: TestResultContext) {
        context.questions.forEach { testQuestion in
            items.append(TestQuestionResultCellViewModel(word: testQuestion.word, answer: testQuestion.answer, correct: testQuestion.translation, isAnswerCorrect: testQuestion.isAnswerCorrect))
        }
    }
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
