//
//  DetailBookSalesView.swift
//  BookStoreStrategiest
//
//  Created by Kunal Kumar R on 20/11/24.
//

import SwiftUI

struct DetailBookSalesView: View {
    
    enum TimeInterval: String, CaseIterable, Identifiable {
        case day = "Day"
        case week = "Week"
        case month = "Month"
        
        var id: Self { return self }
    }
    
    @ObservedObject var viewModel: SalesViewModel
    @State private var selectedTimeInterval = TimeInterval.day
    
    var body: some View {
        VStack {
            Picker(selection: $selectedTimeInterval.animation()) {
                ForEach(TimeInterval.allCases) { timeInterval in
                    Text(timeInterval.rawValue)
                }
            } label: {
                Text("Time interval for chart")
            }
            .pickerStyle(.segmented)
            
            Group {
                Text("You sold") + Text(" \(viewModel.totalSales) books ").bold() + Text("in the last 90 days")
            }
            .padding(.vertical)
            
            Group {
                switch selectedTimeInterval {
                case .day:
                    DailySalesChartView(salesData: viewModel.salesData)
                case .week:
                    WeeklySalesChartView(salesViewModel: viewModel)
                case .month:
                    MonthlySalesChartView(salesData: viewModel.salesData)
                }
            }
            .aspectRatio(0.8, contentMode: .fit)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    DetailBookSalesView(viewModel: .preview)
        .padding()
}
