//
//  ContentView.swift
//  BookStoreStrategiest
//
//  Created by Kunal Kumar R on 20/11/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var salesViewModel = SalesViewModel.preview
    @StateObject var expenseViewModel = ExpensesViewModel.preview
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section {
                        NavigationLink {
                            DetailBookSalesView(viewModel: salesViewModel)
                                .toolbarTitleDisplayMode(.inline)
                        } label: {
                            BookSalesView(viewModel: salesViewModel)
                        }
                    }
                    Section {
                        NavigationLink {
                            SalesPerBookCategoryView(viewModel: salesViewModel)
                                .toolbarTitleDisplayMode(.inline)
                        } label: {
                            SimpleSalesCategoryView(viewModel: salesViewModel)
                        }
                    }
                    Section {
                        NavigationLink {
                            ExpensesDetailView(viewModel: expenseViewModel)
                                .toolbarTitleDisplayMode(.inline)
                        } label: {
                            SimpleExpensesView(viewModel: expenseViewModel)
                        }
                    }
                    Label("The above charts are shown with subject to the data that has been provided.", systemImage: "exclamationmark.circle.fill")
                        .frame(height: 70)
                }
                .navigationTitle("Your Book Store Stats")
            }
        }
    }
}

#Preview {
    ContentView()
}
