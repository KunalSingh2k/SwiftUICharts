//
//  DailySalesChartView.swift
//  BookStoreStrategiest
//
//  Created by Kunal Kumar R on 20/11/24.
//

import SwiftUI
import Charts

struct DailySalesChartView: View {
    let salesData: [Sale]
    let numberOfDisplayDates = 30
    
    var body: some View {
        Chart(salesData) { sale in
            BarMark(x: .value("Day", sale.saleDate, unit: .day),
                    y:  .value("Sale", sale.quantity))
        }
        .chartScrollableAxes(.horizontal)
        .chartXVisibleDomain(length: 3600 * 24 * numberOfDisplayDates)
        .chartScrollTargetBehavior(
            .valueAligned(matching: .init(hour: 0), majorAlignment: .matching(.init(day: 1)))
        )
    }
}

#Preview {
    DailySalesChartView(salesData: Sale.threeMonthsExample())
        .aspectRatio(1, contentMode: .fit)
        .padding()
}
