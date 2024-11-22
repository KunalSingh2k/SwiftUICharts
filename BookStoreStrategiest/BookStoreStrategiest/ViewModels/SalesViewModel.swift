//
//  SalesViewModel.swift
//  BookStoreStrategiest
//
//  Created by Kunal Kumar R on 20/11/24.
//

import Foundation

class SalesViewModel: ObservableObject {
    @Published var salesData = [Sale]()
    @Published var lastTotalSales: Int = 0
    
    var totalSales: Int {
        salesData.reduce(0) { $0 + $1.quantity }
    }
        
    var salesByWeek: [(day: Date, sales: Int)] {
        let salesByWeek = salesGroupedByWeek(sales: salesData)
        return totalSalesPerDay(salesByDate: salesByWeek)
    }
    
    var highestSellingWeekday: (number: Int, sales: Double)? {
        averageSalesByWeekday.max { initial, final in
            initial.sales < final.sales
        }
    }
    
    var averageSalesByWeekday: [(number: Int, sales: Double)] {
        let salesByWeekday = salesGroupedByWeekday(sales: salesData)
        let averageSales = averageSalesByNumber(salesByNumber: salesByWeekday)
        let sorted = averageSales.sorted { $0.number < $1.number }
        return sorted
    }
    
    var salesByWeekday: [(number: Int, sales: [Sale])] {
        let salesByWeekday = salesGroupedByWeekday(sales: salesData).map { (number: $0.key, sales: $0.value) }
        return salesByWeekday.sorted { $0.number < $1.number }
    }
    
    var totalSalesByCategory: [(category: BookCategory, sales: Int)] {
        let salesByCategory = salesGroupedByCategory(sales: salesData)
        let totalSalesPerCategory = totalSalesPerCategory(salesByCategory: salesByCategory)
        return totalSalesPerCategory.sorted{ $0.sales > $1.sales }
    }
    
    var bestSellingCategory: (category: BookCategory, sales: Int)? {
        totalSalesByCategory.max { $0.sales < $1.sales }
    }
    
    init() {
        // fetch data from the server
    }
    
    func fetchSalesData() {
        // TODO: get new data
        
        salesData = Sale.threeMonthsExample()
    }
    
    func salesGroupedByWeek(sales: [Sale]) -> [Date: [Sale]] {
        var salesByWeek: [Date: [Sale]] = [:]
        
        let calendar = Calendar.current
        for sale in sales {
            guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: sale.saleDate)) else { continue }
            if salesByWeek[startOfWeek] != nil {
                salesByWeek[startOfWeek]!.append(sale)
            } else {
                salesByWeek[startOfWeek] = [sale]
            }
        }
        return salesByWeek
    }
    
    func totalSalesPerDay(salesByDate: [Date: [Sale]]) -> [(day: Date, sales: Int)] {
        var totalSales: [(day: Date, sales: Int)] = []
        
        for (date, sales) in salesByDate {
            let totalQuantityForDate = sales.reduce(0) { $0 + $1.quantity }
            totalSales.append((day: date, sales: totalQuantityForDate))
         }
        return totalSales
    }
    
    func salesGroupedByWeekday(sales: [Sale]) -> [Int: [Sale]] {
        var salesByWeekday: [Int: [Sale]] = [:]
        let calendar = Calendar.current
        
        for sale in sales {
            let weekday = calendar.component(.day, from: sale.saleDate)
            if salesByWeekday[weekday] != nil {
                salesByWeekday[weekday]!.append(sale)
            } else {
                salesByWeekday[weekday] = [sale]
            }
        }
        return salesByWeekday
    }
    
    func averageSalesByNumber(salesByNumber: [Int: [Sale]]) -> [(number: Int, sales: Double)] {
        var averageSales: [(number: Int, sales: Double)] = []
        
        for (number, sales) in salesByNumber {
            let count = sales.count
            let totalQuantityForWeekday = sales.reduce(0) { $0 + $1.quantity }
            averageSales.append((number: number, sales: Double(totalQuantityForWeekday)/Double(count)))
        }
        return averageSales
    }
    
    //MARK: - Category sales
    func salesGroupedByCategory(sales: [Sale]) -> [BookCategory: [Sale]] {
        var salesByCategory: [BookCategory: [Sale]] = [:]
        
        for sale in sales {
            let category = sale.book.category
            if salesByCategory[category] != nil {
                salesByCategory[category]!.append(sale)
            } else {
                salesByCategory[category] = [sale]
            }
        }
        return salesByCategory
    }
    
    func totalSalesPerCategory(salesByCategory: [BookCategory: [Sale]]) -> [(category: BookCategory, sales: Int)] {
        var totalSales: [(category: BookCategory, sales: Int)] = []
        
        for(category, sales) in salesByCategory {
            let totalQuantity = sales.reduce(0) { $0 + $1.quantity }
            totalSales.append((category: category, sales: totalQuantity))
        }
        
        return totalSales
    }
    
    
    static var preview: SalesViewModel {
        let vm = SalesViewModel()
        vm.salesData = Sale.threeMonthsExample()
        vm.lastTotalSales = 500
        return vm
    }
}
