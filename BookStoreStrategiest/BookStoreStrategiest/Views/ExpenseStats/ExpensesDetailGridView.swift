//
//  ExpensesDetailGridView.swift
//  BookStoreStrategiest
//
//  Created by Kunal Kumar R on 21/11/24.
//

import SwiftUI

struct ExpensesDetailGridView: View {
    @ObservedObject var viewModel: ExpensesViewModel
    
    var body: some View {
        Grid(alignment: .trailing, horizontalSpacing: 15, verticalSpacing: 20) {
            GridRow {
                Color.clear
                    .gridCellUnsizedAxes([.horizontal, .vertical])
                Text("Fixed")
                    .gridCellAnchor(.center)
                Text("Variable")
                    .gridCellAnchor(.center)
                Text("Total")
                    .gridCellAnchor(.center)
            }
            
            ForEach(viewModel.monthlyExpenseData) { data in
                GridRow {
                    Text(month(for: data.month))
                    Text(String(format: "%.2f", data.fixedExpense))
                    Text(String(format: "%.2f", data.variableExpense))
                    Text(String(format: "%.2f", data.totalExpense))
                        .bold()
                }
            }
            Divider()
            
            GridRow {
                Text("Total")
                    .bold()
                Color.clear
                    .gridCellUnsizedAxes([.horizontal, .vertical])
                    .gridCellColumns(2)
                Text("$" + String(format: "%2.f", viewModel.totalExpense))
                    .bold()
                    .foregroundStyle(.pink)
            }
        }
    }
    let formatter = DateFormatter()
    
    func month(for number: Int) -> String {
        formatter.shortStandaloneMonthSymbols[number - 1]
    }
}

#Preview {
    ExpensesDetailGridView(viewModel: .preview)
        .padding()
}
