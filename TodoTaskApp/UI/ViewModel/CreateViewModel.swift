//
//  CreateViewModel.swift
//  TodoTaskApp
//
//  Created by Tural Babayev on 10.10.2024.
//

import Foundation

class CreateViewModel{
    var taskRepo = TaskRepository()
    
    func createTask(taskName:String){
        taskRepo.createTask(taskName: taskName)
    }
}
