//
//  SecondViewController.swift
//  Table
//
//  Created by Yaroslav Shepilov on 06.09.2021.
//

import UIKit


class SecondViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    let model : PrizeModel
    init(model:PrizeModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.delegate = self
        priceTextField.delegate = self

    }
   
    @IBAction func actionSave(_ sender: Any) {
        guard let title = titleTextField.text, let priceString = priceTextField.text,  let price = Int(priceString) else {
            showAlertForPrice()
            return
        }
        model.createPrize(title: title, price: price)
        navigationController?.popViewController(animated: true)
    }
    
    func showAlertForPrice() {
        let title: String = titleTextField.text ?? "empty"
        let price: String = priceTextField.text ?? "empty"
        let message = "\(title) or \(price) are incorrect"
        let alertForPrice = UIAlertController(title: "Something went wrong", message: message, preferredStyle: .alert)
        let okButtonForPrice = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertForPrice.addAction(okButtonForPrice)

        present(alertForPrice, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return false
    }

}

