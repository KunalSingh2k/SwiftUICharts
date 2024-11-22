//
//  SalesPerCategoryBarChartView.swift
//  BookStoreStrategiest
//
//  Created by Kunal Kumar R on 21/11/24.
//

import SwiftUI
import Charts

struct SalesPerCategoryBarChartView: View {
    @ObservedObject var viewModel: SalesViewModel
    
    var body: some View {
       
        
        Chart(viewModel.totalSalesByCategory, id: \.category) { data in
            BarMark(x: .value("Sales", data.sales), y: .value("Book Category", data.category.displayName))
                .annotation(position: .trailing, alignment: .leading) {
                    Text("\(data.sales)")
                        .opacity(viewModel.bestSellingCategory?.category == data.category ? 1: 0.3)
                }
            
                .cornerRadius(5)
                .opacity(viewModel.bestSellingCategory?.category == data.category ? 1: 0.3)
                .foregroundStyle(by: .value("Category", data.category.displayName))
        }
        .aspectRatio(1, contentMode: .fit)
        .chartLegend(.hidden)
    }
}

#Preview {
    SalesPerCategoryBarChartView(viewModel: .preview)
        .padding()
}
