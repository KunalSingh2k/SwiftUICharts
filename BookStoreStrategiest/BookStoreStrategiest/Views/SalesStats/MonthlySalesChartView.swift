//
//  MonthlySalesChartView.swift
//  BookStoreStrategiest
//
//  Created by Kunal Kumar R on 20/11/24.
//

import SwiftUI
import Charts

struct MonthlySalesChartView: View {
    let salesData: [Sale]
    
    var body: some View {
        Chart(salesData) { sale in
            BarMark(x: .value("Day", sale.saleDate, unit: .month),
                    y:  .value("Sale", sale.quantity))
        }
        .chartXAxis {
            AxisMarks { _ in
                AxisValueLabel(format: .dateTime.month(.abbreviated), centered: true)
            }
        }
    }
}

#Preview {
    MonthlySalesChartView(salesData: Sale.threeMonthsExample())
        .aspectRatio(1, contentMode: .fit)
        .padding()
}
