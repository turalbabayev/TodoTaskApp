//
//  DetailViewModel.swift
//  TodoTaskApp
//
//  Created by Tural Babayev on 10.10.2024.
//

import Foundation

class DetailViewModel{
    var taskRepo = TaskRepository()
    
    func updateTask(taskId: Int, taskName: String){
        taskRepo.update(taskId: taskId, taskName: taskName)
    }
    
    func delete(taskId: Int){
        taskRepo.delete(taskId: taskId)
        taskRepo.loadTask()
    }
}
