//
//  SimpleSalesCategoryView.swift
//  BookStoreStrategiest
//
//  Created by Kunal Kumar R on 20/11/24.
//

import SwiftUI
import Charts

struct SimpleSalesCategoryView: View {
    @ObservedObject var viewModel: SalesViewModel
    
    var body: some View {
        HStack {
            SalesPerBookCategoryHeaderView(viewModel: viewModel)
            
            Chart(viewModel.totalSalesByCategory, id: \.category) { data in
                SectorMark(angle: .value("Book Category", data.sales), innerRadius: .ratio(0.618), angularInset: 1.5)
                    .cornerRadius(5)
                    .opacity(viewModel.bestSellingCategory?.category == data.category ? 1: 0.3)
            }
            .aspectRatio(1, contentMode: .fit)
            .frame(height: 70)
        }
    }
}

#Preview {
    SimpleSalesCategoryView(viewModel: .preview)
        .padding()
}
