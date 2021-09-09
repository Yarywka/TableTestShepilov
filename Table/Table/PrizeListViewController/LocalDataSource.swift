//
//  LocalDataSource.swift
//  Table
//
//  Created by Yaroslav Shepilov on 07.09.2021.
//

import Foundation

struct LocalDataSource {
    private let userDefaults = UserDefaults.standard
    private let key = "storedDataSourceKey"
    
    private var predefinedDataSource = [
        Prize(title: "Mars", price: 10, isSelected: false),
        Prize(title: "Nuts", price: 10, isSelected: false),
        Prize(title: "Snikers", price: 10, isSelected: false),
        Prize(title: "Bounty", price: 10, isSelected: false),
        Prize(title: "Hubba bubba", price: 10, isSelected: false),
        Prize(title: "Bud", price: 10, isSelected: false),
        Prize(title: "Corona Extra", price: 10, isSelected: false),
        Prize(title: "Hoegaarden", price: 10, isSelected: false),
        Prize(title: "Donut", price: 10, isSelected: false),
        Prize(title: "Cookie", price: 10, isSelected: false),
        Prize(title: "Cake", price: 10, isSelected: false),
        Prize(title: "Book", price: 10, isSelected: false),
        ]
    
    func saveDataSource(dataSource: [Prize]) {
        let data = try? PropertyListEncoder().encode(dataSource)
        userDefaults.set(data, forKey: key)
    }
    
    func readDataSource() -> [Prize] {
        guard
            let dataArray = userDefaults.value(forKey: key) as? Data,
            let decodedArray = try? PropertyListDecoder().decode([Prize].self, from: dataArray)
        else {
            return predefinedDataSource
        }
        return decodedArray
    }
}
