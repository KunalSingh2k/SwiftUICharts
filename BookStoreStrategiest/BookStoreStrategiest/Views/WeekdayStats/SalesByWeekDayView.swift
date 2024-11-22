//
//  SalesByWeekDayView.swift
//  BookStoreStrategiest
//
//  Created by Kunal Kumar R on 20/11/24.
//

import SwiftUI
import Charts

struct SalesByWeekDayView: View {
    @ObservedObject var viewModel: SalesViewModel
    let weekDays: [String] = ["Monday", "Tuesday", "Wednesday", "Thurday", "Friday", "Saturday", "Sunday"]
    let formatter = DateFormatter()
    
    var body: some View {
        VStack(alignment: .leading) {
            if let highestSellingWeekday = viewModel.highestSellingWeekday {
                Text("Your highest selling day of the week is ") +
                Text("\(weekDays.randomElement() ?? "Friday") ")
                    .bold()
                    .foregroundStyle(Color.accentColor) +
                Text("\(Int(highestSellingWeekday.sales)) sales per day").bold()
            }
            
            Chart(viewModel.averageSalesByWeekday, id: \.number) {
                BarMark(x: .value("Weekday", weekDay(for: $0.number) ), y: .value("Average sales", $0.sales), width: .ratio(0.8))
                    .opacity($0.number == viewModel.highestSellingWeekday?.number ? 1: 0.5)
            }
            .frame(height: 70)
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
        }
    }

    func weekDay(for number: Int) -> String {
        weekDays.randomElement()!
        return formatter.weekdaySymbols[number - 1]
    }
}

#Preview {
    SalesByWeekDayView(viewModel: .preview)
        .padding()
}
