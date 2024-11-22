//
//  SalesPerBookCategoryView.swift
//  BookStoreStrategiest
//
//  Created by Kunal Kumar R on 21/11/24.
//

import SwiftUI

struct SalesPerBookCategoryView: View {
    
    enum ChartStyle: CaseIterable, Identifiable {
        case pie
        case bar
        
        var id: Self { self }
        var displayName: String {
            switch self {
            case .pie:
                "Pie Chart"
            case .bar:
                "Bar Chart"
            }
        }
    }
    
    @ObservedObject var viewModel: SalesViewModel
    @State private var selectedChartStyle: ChartStyle = .pie
    
    var body: some View {
        VStack(spacing: 20) {
            Picker("Chart Type", selection: $selectedChartStyle.animation()) {
                ForEach(ChartStyle.allCases) {
                    Text($0.displayName)
                }
            }
            .pickerStyle(.segmented)
            
            SalesPerBookCategoryHeaderView(viewModel: viewModel)
            
            switch selectedChartStyle {
            case .pie:
                SalesPerCategoryPieChartView(viewModel: viewModel)
            case .bar:
                SalesPerCategoryBarChartView(viewModel: viewModel)
            }
            
            Button {
                withAnimation {
                    viewModel.fetchSalesData()
                }
            } label: {
                Label("Refresh", systemImage: "arrow.triangle.2.circlepath")
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    SalesPerBookCategoryView(viewModel: .preview)
        .padding()
}
