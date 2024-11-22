//
//  ExpensesBarChartView.swift
//  BookStoreStrategiest
//
//  Created by Kunal Kumar R on 21/11/24.
//

import SwiftUI
import Charts

struct ExpensesBarChartView: View {
    @ObservedObject var viewModel: ExpensesViewModel
    var body: some View {
        Chart(viewModel.monthlyExpenseData) { data in
            Plot {
                BarMark(x: .value("Month", month(for: data.month)), y: .value("Expenses", data.fixedExpense))
                    .foregroundStyle(by: .value("Expenses", "Fixed"))
                    .position(by: .value("Expenses", "Fixed"))
                
                BarMark(x: .value("Month", month(for: data.month)), y: .value("Expenses", data.variableExpense))
                    .foregroundStyle(by: .value("Expenses", "Variable"))
                    .position(by: .value("Expenses", "Variable"))
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
    
    let formatter = DateFormatter()
    
    func month(for number: Int) -> String {
        formatter.shortStandaloneMonthSymbols[number - 1]
    }
}

#Preview {
    ExpensesBarChartView(viewModel: .preview)
        .padding()
}
