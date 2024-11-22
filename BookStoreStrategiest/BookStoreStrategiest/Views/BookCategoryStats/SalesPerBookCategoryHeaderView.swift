//
//  SalesPerBookCategoryHeaderView.swift
//  BookStoreStrategiest
//
//  Created by Kunal Kumar R on 20/11/24.
//

import SwiftUI

struct SalesPerBookCategoryHeaderView: View {
    @ObservedObject var viewModel: SalesViewModel
    
    var body: some View {
        if let bestSellingCategory = viewModel.bestSellingCategory {
            Text("Your best selling category is ") +
            Text("\(bestSellingCategory.category.displayName) ").bold()
                .foregroundStyle(Color.accentColor) +
            Text("With ") + Text(bestsellingCategoryPercentage ?? "").bold() +
            Text(" of all sales.")
        }
    }
    
    var bestsellingCategoryPercentage: String? {
        guard let bestSellingCategory = viewModel.bestSellingCategory
        else { return nil}
        let percentage = Double(bestSellingCategory.sales) / Double(viewModel.totalSales)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        guard let formattedPercentage = numberFormatter.string(from:
        NSNumber (value: percentage)) else { return nil }
        return formattedPercentage
    }
}

#Preview {
    SalesPerBookCategoryHeaderView(viewModel: .preview)
}
