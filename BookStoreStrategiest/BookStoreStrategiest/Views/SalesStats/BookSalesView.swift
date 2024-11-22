//
//  BookSalesView.swift
//  BookStoreStrategiest
//
//  Created by Kunal Kumar R on 20/11/24.
//

import SwiftUI

struct BookSalesView: View {
    @ObservedObject var viewModel: SalesViewModel
    
    var body: some View {
        VStack {
                if let changesInBookSales = changesInBookSales() {
                    HStack(alignment: .firstTextBaseline) {
                        Image(systemName: isPositiveChange ? "arrow.up.right": "arrow.down.right").bold()
                            .foregroundStyle(isPositiveChange ? .green: .red)
                        
                        Text("Your book sales ") + Text(changesInBookSales).bold() + Text(" in the last 90 days")
                    }
            }
            
            WeeklySalesChartView(salesViewModel: viewModel)
                .frame(height: 70)
                .chartXAxis(.hidden)
                .chartYAxis(.hidden)
        }
    }
    
    var percentage: Double {
        Double(viewModel.totalSales) / Double(viewModel.lastTotalSales) - 1
    }
    
    var isPositiveChange: Bool {
        percentage > 0
    }
    
    func changesInBookSales() -> String? {
        let percentage = percentage
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        
        guard let formattedPercentage = numberFormatter.string(from: NSNumber(value: percentage)) else { return nil }
        let changedDescription = percentage < 0 ? "Decreased By ": "Increased By "
        return changedDescription + formattedPercentage
    }
}

#Preview {
    BookSalesView(viewModel: .preview)
        .padding()
}

#Preview("negative") {
    let decreasedVM = SalesViewModel.preview
    decreasedVM.lastTotalSales = 1000
    
   return BookSalesView(viewModel: decreasedVM)
        .padding()
}

