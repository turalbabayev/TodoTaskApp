//
//  CreateViewController.swift
//  TodoTaskApp
//
//  Created by Tural Babayev on 10.10.2024.
//

import UIKit

class CreateViewController: UIViewController {
    @IBOutlet weak var textView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet weak var clearButtonOutlet: UIButton!
    @IBOutlet weak var buttonSaveOutlet: UIButton!
    var viewModel = CreateViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.layer.cornerRadius = 12
        textField.borderStyle = .none
        secondView.layer.cornerRadius = 15
    }
    @IBAction func buttonBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buttonClearAction(_ sender: Any) {
        textField.text = ""
    }
    
    @IBAction func buttonSaveAction(_ sender: Any) {
        if textField.text != "" {
            if let taskName = textField.text {
                viewModel.createTask(taskName: taskName)
                let alert = UIAlertController(title: "Başarılı", message: "Gorev başarıyla eklendi.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Tamam", style: .default){ action in
                    self.navigationController?.popViewController(animated: true)
                }
                
                alert.addAction(okAction)
                
                self.present(alert, animated: true)
            }
        }else{
            let alert = UIAlertController(title: "Hata", message: "Lütfen görev adı yazınız.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Tamam", style: .default)
            
            alert.addAction(okAction)
            
            self.present(alert, animated: true)
        }
        
    }
    
    
    
    
}
