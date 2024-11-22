//
//  WeeklySalesChartView.swift
//  BookStoreStrategiest
//
//  Created by Kunal Kumar R on 20/11/24.
//

import SwiftUI
import Charts

struct WeeklySalesChartView: View {
    @ObservedObject var salesViewModel: SalesViewModel
    @State private var selectedDate: Date? = nil
    @Environment(\.calendar) var calendar
    
    var selectedDateValue: (day: Date, sales: Int)? {
        if let selectedDate {
            return salesViewModel.salesByWeek.first {
                let startOfWeek = $0.day
                let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek) ?? Date()
                return (startOfWeek...endOfWeek).contains(selectedDate)
            }
        } else {
            return nil
        }
    }
    
    var body: some View {
        Chart {
            ForEach(salesViewModel.salesByWeek, id: \.day) { saleDate in
                BarMark(x: .value("Day", saleDate.day, unit: .weekOfYear),
                        y:  .value("Sale", saleDate.sales))
                .opacity(selectedDateValue?.day == nil || selectedDateValue?.day == saleDate.day ? 1: 0.5)
            }
            if let selectedDate {
                RuleMark(x: .value("Selected Date", selectedDate, unit: .weekOfYear))
                    .foregroundStyle(.gray.opacity(0.3))
                    .zIndex(-1)
                    .annotation(position: .top, spacing: 0, overflowResolution: .init(x: .fit(to: .chart), y: .disabled)) {
                        selectionPopOver
                    }
            }
        }
        .chartXSelection(value: $selectedDate)
    }
    
    @ViewBuilder
    var selectionPopOver: some View {
        if let selectedDateValue {
            VStack {
                Text(selectedDateValue.day.formatted(.dateTime.month().day()))
                Text("\(selectedDateValue.sales) sales")
            }
            .padding(6)
            .background {
                RoundedRectangle(cornerRadius: 4)
                    .fill(.white)
                    .shadow(color: .blue, radius: 2)
            }
        }
    }
}

struct PlainWeeklySalesChartView: View {
    let salesData: [Sale]
    
    var body: some View {
        Chart(salesData) { sale in
            BarMark(x: .value("Day", sale.saleDate, unit: .weekOfYear),
                    y:  .value("Sale", sale.quantity))
        }
    }
}

#Preview {
    WeeklySalesChartView(salesViewModel: SalesViewModel.preview)
        .aspectRatio(1, contentMode: .fit)
        .padding()
}

#Preview("Plain") {
    PlainWeeklySalesChartView(salesData: Sale.threeMonthsExample())
        .aspectRatio(1, contentMode: .fit)
        .padding()
}
