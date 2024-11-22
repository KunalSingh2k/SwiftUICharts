//
//  SimpleExpensesView.swift
//  BookStoreStrategiest
//
//  Created by Kunal Kumar R on 21/11/24.
//

import SwiftUI
import Charts

struct SimpleExpensesView: View {
    @ObservedObject var viewModel: ExpensesViewModel
    
    let linearGradient = LinearGradient(colors: [.pink.opacity(0.7), .pink.opacity(0)], startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        VStack {
            Text("Your total expenses for the last year are ") +
            Text("$\(String(format: "%.2f", viewModel.totalExpense))")
                .bold()
                .foregroundStyle(.pink)
            
            Chart(viewModel.monthlyExpenseData) { data in
                AreaMark(x: .value("Month", data.month), y: .value("Expenses", data.totalExpense))
                    .foregroundStyle(linearGradient)
            }
            .frame(height: 70)
            .chartXScale(domain: 1...12)
            .chartYAxis(.hidden)
        }
    }
}

#Preview {
    SimpleExpensesView(viewModel: .preview)
        .padding()
}
