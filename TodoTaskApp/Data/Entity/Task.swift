//
//  Task.swift
//  TodoTaskApp
//
//  Created by Tural Babayev on 10.10.2024.
//

import Foundation

class Task{
    var id: Int?
    var name: String?
    var createdAt: Date?
    
    init(id: Int, name: String, createdAt: Date) {
        self.id = id
        self.name = name
        self.createdAt = createdAt
    }
}
