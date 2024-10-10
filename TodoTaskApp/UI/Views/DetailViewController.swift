//
//  UpdateViewController.swift
//  TodoTaskApp
//
//  Created by Tural Babayev on 10.10.2024.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var textView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var buttonClearOutlet: UIButton!
    @IBOutlet weak var buttonUpdateOutlet: UIButton!
    
    
    var task: Task?
    var viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.layer.cornerRadius = 12
        textField.borderStyle = .none
        secondView.layer.cornerRadius = 15
        
        
        if let t = task{
            textField.text = t.name
        }
    }
    
    @IBAction func buttonBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buttonClearAction(_ sender: Any) {
        textField.text = ""
    }
    
    @IBAction func buttonUpdateAction(_ sender: Any) {
        if textField.text == ""{
            let alert = UIAlertController(title: "Hata", message: "Görev adı boş bırakılamaz.!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Tamam", style: .default)
            
            alert.addAction(okAction)
            
            self.present(alert, animated: true)
        }else{
            if let t = task, let taskName = textField.text{
                viewModel.updateTask(taskId: t.id!, taskName: taskName)
                let alert = UIAlertController(title: "Başarılı", message: "Görev başarıyla güncellendi.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Tamam", style: .default){ _ in
                    self.navigationController?.popViewController(animated: true)
                }
                alert.addAction(okAction)
                
                self.present(alert, animated: true)
            }
        }
    }
    
    @IBAction func buttonDeleteAction(_ sender: UIButton) {
        if let t = task{
            let alert = UIAlertController(title: "Silme İşlemi", message: "\(t.name!) silinsin mi?", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Evet", style: .destructive){ _ in
                self.viewModel.delete(taskId: t.id!)
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(okAction)
            
            let cancelAction = UIAlertAction(title: "İptal", style: .cancel)
            alert.addAction(cancelAction)

            
            self.present(alert, animated: true)

        }
    }
    
    
    

}
