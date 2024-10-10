//
//  TaskRepository.swift
//  TodoTaskApp
//
//  Created by Tural Babayev on 10.10.2024.
//

import Foundation
import RxSwift

class TaskRepository{
    var taskList = BehaviorSubject<[Task]>(value: [Task]())
    let db:FMDatabase?

    
    init(){
        let destionationPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let databaseURL = URL(fileURLWithPath: destionationPath).appendingPathComponent("task.sqlite")
        db = FMDatabase(path: databaseURL.path)
    }
    
    func createTask(taskName:String){
        db?.open()
        
        do{
            try db!.executeUpdate("INSERT INTO task (name) VALUES (?)", values: [taskName])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func update(taskId:Int,taskName:String){
        db?.open()
        
        do{
            try db!.executeUpdate("UPDATE task SET name = ? WHERE id = ?", values: [taskName,taskId])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func delete(taskId:Int){
        db?.open()
        
        do{
            try db!.executeUpdate("DELETE FROM task WHERE id = ?", values: [taskId])
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    func searchTask(searchText:String){
        db?.open()
        
        do{
            var list = [Task]()
            
            let rs = try db!.executeQuery("SELECT * FROM task WHERE name like '%\(searchText)%' ", values: nil)
            
            while rs.next() {
                let taskId = Int(rs.string(forColumn: "id")!)
                let taskName = rs.string(forColumn: "name")
                
                let task = Task(id: taskId!, name: taskName!, createdAt: Date())
                list.append(task)
            }
            
            taskList.onNext(list)//Tetikleme
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func loadTask(){
        db?.open()
        
        do{
            var list = [Task]()
            
            let rs = try db!.executeQuery("SELECT * FROM task", values: nil)
            
            while rs.next() {
                let taskId = Int(rs.string(forColumn: "id")!)
                let taskName = rs.string(forColumn: "name")
                
                let task = Task(id: taskId!, name: taskName!,createdAt: Date())
                list.append(task)
            }
            taskList.onNext(list)//Tetikleme
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    

}
