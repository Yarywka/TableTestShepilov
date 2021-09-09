//
//  Model.swift
//  Table
//
//  Created by Yaroslav Shepilov on 02.09.2021.
//

import Foundation

protocol PrizeModelDelegate {
    func showAlert()
    func updateTitle()
    func reloadTableView()
}

class PrizeModel {
    var delegate : PrizeModelDelegate?
    private let localDataSource = LocalDataSource()
    var dataSource : [Prize]
    let maxValue = 100
    var sum = 0
    
    init() {
        self.dataSource = localDataSource.readDataSource()
        calculateSum()
    }
   
    // calculate and select cell
    func updateSum(index: Int) {
        if dataSource[index].isSelected == true {
            dataSource[index].isSelected = false
        } else {
            if sum + dataSource[index].price > maxValue {
                delegate?.showAlert()
                // сюда зайдем если макс значение выбранных призов больше 100 и юзер хочет еще выбрать приз сделать = убрать такое колво строк чтобы сумма была <= 100
                // dataSource.first { prize in prize.isSelected == true }
            } else {
                dataSource[index].isSelected = !dataSource[index].isSelected
            }
        }
        calculateSum()
        save()
        delegate?.reloadTableView()
    }
    
    // sum for user
    func getTitle() -> String {
        return "sum is equal \(sum)"
    }
    
    // create and appending new prize
    func createPrize(title: String, price: Int) {
        let prize = Prize(title: title, price: price, isSelected: false)
        dataSource.append(prize)
        save()
        delegate?.reloadTableView()
    }
    
    // delete prizes and calculate again and again
    func deletePrize(indexPath: Int) {
        dataSource.remove(at: indexPath)
        calculateSum()
        save()
        delegate?.reloadTableView()
    }
    
    func calculateSum() {
        let filteredArray = dataSource.filter { (prize) -> Bool in
            prize.isSelected == true
        }
        var filteredSum = 0
             for number in filteredArray {
                filteredSum += number.price
                delegate?.reloadTableView()
             }
        sum = filteredSum
        delegate?.updateTitle()
    }
    
    func save() {
       localDataSource.saveDataSource(dataSource: dataSource)
    }
}
 
struct Prize : Equatable, Codable {
    let title: String
    let price: Int
    var isSelected: Bool
}

