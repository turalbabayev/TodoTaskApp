//
//  HomeViewModel.swift
//  TodoTaskApp
//
//  Created by Tural Babayev on 10.10.2024.
//

import Foundation
import RxSwift

class HomeViewModel{
    let taskRepo = TaskRepository()
    var taskList = BehaviorSubject<[Task]>(value: [Task]())
    private let messageProvider = MotivationalMessageProvider()

    
    init(){
        copyDatabase()
        loadTask()
        taskList = taskRepo.taskList
    }
    
    func delete(taskId: Int){
        taskRepo.delete(taskId: taskId)
        loadTask()
    }
    
    func search(searchText: String){
        taskRepo.searchTask(searchText: searchText)
    }
    
    func loadTask(){
        taskRepo.loadTask()
        
    }
    
    func copyDatabase(){
        let bundlePath = Bundle.main.path(forResource: "task", ofType: ".sqlite")
        let destionationPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let copyPath = URL(fileURLWithPath: destionationPath).appendingPathComponent("task.sqlite")
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: copyPath.path){
            print("Veritabanı zaten var")
        }else{
            do{
                if let bundlePath = bundlePath {
                    try fileManager.copyItem(atPath: bundlePath, toPath: copyPath.path)
                    print("Veritabanı başarıyla kopyalandı")
                } else {
                    print("Veritabanı bundle'da bulunamadı")
                }
            }catch{
                print("Veritabanı kopyalanırken hata oluştu: \(error.localizedDescription)")
            }
        }
    }
    
    // Görevle ilgili rastgele bir motivasyon mesajı döner
    func getMotivationalMessage() -> String {
        return messageProvider.getRandomMessage()
    }



}
