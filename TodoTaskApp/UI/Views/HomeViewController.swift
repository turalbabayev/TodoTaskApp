//
//  ViewController.swift
//  TodoTaskApp
//
//  Created by Tural Babayev on 10.10.2024.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var labelSubTitle: UILabel!
    @IBOutlet weak var taskTableView: UITableView!
    @IBOutlet weak var emptyListLabel: UILabel!
    @IBOutlet weak var searchBar: UITextField!
    
    
    var taskList = [Task]()
    var viewModel = HomeViewModel()
    var helper = UIHelper()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskTableView.dataSource = self
        taskTableView.delegate = self
        searchBar.delegate = self
        secondView.layer.cornerRadius = 15
        navigationController?.navigationBar.backItem?.hidesBackButton = true
        state()
        helper.customizeTextField(to: searchBar)
        
        _ = viewModel.taskList.subscribe(onNext: { list in
            self.taskList = list
            self.taskTableView.reloadData()
            self.state()
        })
        
        labelSubTitle.text = "Harika gidiyorsun! Listende şu an \(taskList.count) görev var."

        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadTask()
        state()
    }
    
    

    @IBAction func buttonDetailAction(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: taskTableView)
        if let indexPath = taskTableView.indexPathForRow(at: point) {
                let selectedTask = taskList[indexPath.row]
                performSegue(withIdentifier: "detailVC", sender: selectedTask)
            }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailVC" {
            if let t = sender as? Task {
                let nextVC = segue.destination as! DetailViewController
                nextVC.task = t
            }
        }
    }
    
    func state(){
        if taskList.count == 0{
            emptyListLabel.isHidden = false
            taskTableView.isHidden = true
        }else{
            emptyListLabel.isHidden = true
            taskTableView.isHidden = false
        }
        
        labelSubTitle.text = "Harika gidiyorsun! Listende şu an \(taskList.count) görev var."
    }
}

extension HomeViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        print("Arama metni değişti: \(currentText)")
        viewModel.search(searchText: currentText)
        return true
        }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count // Her section'da bir hücre olacak
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = taskList[indexPath.row]
        let taskCell = taskTableView.dequeueReusableCell(withIdentifier: "taskCell") as! TaskTableViewCell
        
        taskCell.taskName.text = task.name
        // Görevin eklendiği zamana göre geçen süreyi hesaplayıp gösterelim
        taskCell.taskMotivationMessage.text = viewModel.getMotivationalMessage()
        
        //taskCell.cellBackgroundView.backgroundColor = UIColor.white
        taskCell.cellBackgroundView.layer.cornerRadius = 20
        taskCell.contentView.layer.masksToBounds = true
        taskCell.contentView.backgroundColor = UIColor.white
        
        
        
        taskCell.cellBackgroundView.backgroundColor = UIColor.white

        taskCell.buttonDetailOutlet.tintColor = taskCell.cellBackgroundView.backgroundColor

        
        
        return taskCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil"){ contextualAction,view,bool in
            let task = self.taskList[indexPath.row]
            
            let alert = UIAlertController(title: "Silme İşlemi", message: "\(task.name!) silinsin mi?", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "İptal", style: .cancel)
            alert.addAction(cancelAction)
            
            let yesAction = UIAlertAction(title: "Evet", style: .destructive){ action in
                self.viewModel.delete(taskId: task.id!)
            }
            alert.addAction(yesAction)
            
            self.present(alert, animated: true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}

