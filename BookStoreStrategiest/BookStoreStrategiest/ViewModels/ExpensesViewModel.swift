//
//  ExpensesViewModel.swift
//  BookStoreStrategiest
//
//  Created by Kunal Kumar R on 21/11/24.
//

import Foundation
import Combine

class ExpensesViewModel: ObservableObject {
    @Published private var expenses: [Expense] = []
    @Published var monthlyExpenseData: [ExpensesStates] = []
    @Published var totalExpense: Double = 0
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        // fetch data from server
        
        $expenses.sink { [unowned self] expense in
            let fixedExpense = self.expenseByMonth(for: .fixed, expenses: expense)
            let variableExpense = self.expenseByMonth(for: .variable, expenses: expense)
            self.monthlyExpenseData = self.calculateMonthlyExpenses(fixedExpense: fixedExpense, variableExpense: variableExpense)
            self.totalExpense = calculateTotal(for: expense)
        }
        .store(in: &subscriptions)
    }
    
    func expenseByMonth(for category: ExpenseCategory, expenses: [Expense]) -> [(month: Int, amount: Double)] {
        let calendar = Calendar.current
        var expenseByMonth: [Int: Double] = [:]
        
        for expense in expenses where expense.category == category {
            let month = calendar.component(.month, from: expense.expenseDate)
            expenseByMonth[month, default: 0] += expense.amount
        }
        let result = expenseByMonth.map { (month: $0.key, amount: $0.value) }
        
        return result.sorted { $0.month < $1.month }
    }
    
    func calculateMonthlyExpenses(fixedExpense: [(month: Int, amount: Double)], variableExpense: [(month: Int, amount: Double)]) -> [ExpensesStates] {
        var result = [ExpensesStates]()
        let count = min(fixedExpense.count, variableExpense.count)
        
        for index in 0..<count {
            let month = fixedExpense[index].month
            result.append(ExpensesStates(month: month, fixedExpense: fixedExpense[index].amount, variableExpense: variableExpense[index].amount))
        }
        return result
    }
    
    func calculateTotal(for expenses: [Expense]) -> Double {
        let totalExpense = expenses.reduce(0) { total, expense in
            total + expense.amount
        }
        return totalExpense
    }
    
    static var preview: ExpensesViewModel {
        let vm = ExpensesViewModel()
        vm.expenses = Expense.yearExamples
        return vm
    }
}

struct ExpensesStates: Identifiable {
    let month: Int
    let fixedExpense: Double
    let variableExpense: Double
    
    var totalExpense: Double {
        fixedExpense + variableExpense
    }
    
    var id: Int { return month }
}
