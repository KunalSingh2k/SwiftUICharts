//
//  SalesPerCategoryPieChartView.swift
//  BookStoreStrategiest
//
//  Created by Kunal Kumar R on 20/11/24.
//

import SwiftUI
import Charts

struct SalesPerCategoryPieChartView: View {
    @ObservedObject var viewModel: SalesViewModel
    
    var body: some View {
        Chart(viewModel.totalSalesByCategory, id: \.category) { data in
            SectorMark(angle: .value("Book Category", data.sales), innerRadius: .ratio(0.618), angularInset: 1.5)
                .cornerRadius(5)
                .opacity(viewModel.bestSellingCategory?.category == data.category ? 1: 0.3)
                .foregroundStyle(by: .value("Category", data.category.displayName))
        }
        .aspectRatio(1, contentMode: .fit)
        .chartLegend(spacing: 20)
        .chartBackground { chartProxy in
            GeometryReader { geometry in
                let frame = geometry[chartProxy.plotFrame!]
                let visibleSize = min(frame.width, frame.height)
                
                if let bestSellingCategory = viewModel.bestSellingCategory {
                    VStack(spacing: 5) {
                       Text("Most Sold Category")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                        Text(bestSellingCategory.category.displayName)
                            .font(.title2.bold())
                            .foregroundStyle(.primary)
                        Text(bestSellingCategory.sales.formatted() + " Sold")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: visibleSize * 0.618, maxHeight: visibleSize * 0.618)
                    .position(x: frame.midX, y: frame.midY)
                }
            }
        }
    }
}

#Preview {
    SalesPerCategoryPieChartView(viewModel: .preview)
        .padding()
}
