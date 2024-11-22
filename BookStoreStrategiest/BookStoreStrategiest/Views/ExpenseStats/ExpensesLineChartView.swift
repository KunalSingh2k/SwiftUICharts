//
//  ExpensesLineChartView.swift
//  BookStoreStrategiest
//
//  Created by Kunal Kumar R on 21/11/24.
//

import SwiftUI
import Charts

struct ExpensesLineChartView: View {
    @ObservedObject var viewModel: ExpensesViewModel
    
    var body: some View {
            Chart(viewModel.monthlyExpenseData) { data in
                Plot {
                    LineMark(x: .value("Month", data.month), y: .value("Expenses", data.fixedExpense))
                        .foregroundStyle(by: .value("Expenses", "Fixed"))
                        .symbol(by: .value("Expenses", "Fixed"))
                    
                    LineMark(x: .value("Month", data.month), y: .value("Expenses", data.variableExpense))
                        .foregroundStyle(by: .value("Expenses", "Variable"))
                        .symbol(by: .value("Expenses", "Variable"))
                }
            }
            .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    ExpensesLineChartView(viewModel: .preview)
        .padding()
}
