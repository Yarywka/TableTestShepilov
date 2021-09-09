//
//  ViewController.swift
//  Table
//
//  Created by Yaroslav Shepilov on 01.09.2021.
//

import UIKit

class ViewController: UIViewController, PrizeModelDelegate {
    
    @IBOutlet var tableView : UITableView!
    
    let model = PrizeModel()
    
    private let cellReuseIdentifier = "cellReuseIdentifier"
    
     override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        model.delegate = self
        updateTitle()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(didTapButtonAdd))
        // Do any additional setup after loading the view.
    }
        
    @objc private func didTapButtonAdd() {
        let nextViewController = SecondViewController(model: model)
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func showAlert() {
        let alertForMaxValue = UIAlertController(title: nil, message: "The maximum amount of the selected prizes exceeds your bonus limit! Please remove the previous prizes to add new ones", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertForMaxValue.addAction(okButton)

        present(alertForMaxValue, animated: true, completion: nil)
    }
    
    func updateTitle() {
        title = model.getTitle()
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
}

extension ViewController : UITableViewDelegate {
    public func tableView (_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        model.updateSum(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            model.deletePrize(indexPath: indexPath.row)
        }
    }
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.dataSource.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellReuseIdentifier)
        cell.selectionStyle = .none
        cell.textLabel?.text = model.dataSource[indexPath.row].title
        cell.detailTextLabel?.text = "\(model.dataSource[indexPath.row].price)"
        if model.dataSource[indexPath.row].isSelected == true {
            cell.accessoryType = .checkmark
            cell.backgroundColor = UIColor.green
        }
        return cell
    }
}

