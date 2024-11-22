//
//  ExpensesDetailView.swift
//  BookStoreStrategiest
//
//  Created by Kunal Kumar R on 21/11/24.
//

import SwiftUI

struct ExpensesDetailView: View {
    @ObservedObject var viewModel: ExpensesViewModel
    
    var body: some View {
        List {
            Group {
                Section {
                    ExpensesLineChartView(viewModel: viewModel)
                }
                
                Section {
                    Text("Detail Breakdown of your Expenses per month")
                        .bold()
                        .padding(.top, 30)
                    ExpensesDetailGridView(viewModel: viewModel)
                }
            }
            .listRowSeparator(.hidden)
            .listRowInsets(.init(top: 5, leading: 20, bottom: 5, trailing: 20))
        }
        .listStyle(.plain)
    }
}

#Preview {
    ExpensesDetailView(viewModel: .preview)
}
