//
//  CoreDataManager.swift
//  ToDoApp
//
//  Created by Youngbin Choi on 4/6/24.
//

import Foundation
import UIKit
import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init(){}
    
    // 앱 델리게이트
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    // 데이터 관리자..?
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    // 엔티티명
    let modelName: String = "ToDoData"
    
    
    // MARK: - Read
    func getToDoListFromCoreDate() -> [ToDoData] {
        
        var toDoList: [ToDoData] = []
        
        if let context = context {
            // 요청서
            let request = NSFetchRequest<NSManagedObject>(entityName: modelName)
            // 정렬순서
            let dateOrder = NSSortDescriptor(key: "date", ascending: false)
            request.sortDescriptors = [dateOrder]
            do {
                if let fetchedToDoList = try context.fetch(request) as? [ToDoData] {
                    toDoList = fetchedToDoList
                }
            } catch {
                print("fetch 실패")
            }
        }
        return toDoList
    }
    
    
    // MARK: - Create
    func saveToDoData(toToText: String?, colorInt: Int64, completion: () -> Void) {
        if let context = context {
            // 엔티티 파악하기
            if let entity = NSEntityDescription.entity(forEntityName: modelName, in: context) {
                // 객체 만들기
                if let toDoData = NSManagedObject(entity: entity, insertInto: context) as? ToDoData {
                    toDoData.memoText = toToText
                    toDoData.color = colorInt
                    toDoData.date = Date()
                    
                    // 이렇게 하는게 제일 심플
//                    appDelegate?.saveContext()
                    // 윗줄 코드를 풀어쓰면
                    do {
                        try context.save()
                        completion()
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
    
    // MARK: - Delete
    func deleteToDo(data : ToDoData) {
        guard let date = data.date else { return }
        
        if let context = context {
            // 요청서
            let request = NSFetchRequest<NSManagedObject>(entityName: modelName)
            // 단서
            request.predicate = NSPredicate(format: "date = %@", date as CVarArg)
            
            do {
                if let fetchedToDoList = try context.fetch(request) as? [ToDoData] {
                    if let targetToDo = fetchedToDoList.first {
                        context.delete(targetToDo)
                        
                        // 이제부턴 이걸로
                        appDelegate?.saveContext()
                    }
                }
                
            } catch {
                print("delete 실패")
            }
        }
    }
    
    // MARK: - Update
    func updateToDo(newToDoData: ToDoData, completion: () -> Void) {
        guard let date = newToDoData.date else { return }
        
        if let context = context {
            
            // 여기서는 제네릭에 ToDoData를 넣겠음 -> fetch 후 타입캐스팅이 필요없음!
            let request = NSFetchRequest<ToDoData>(entityName: modelName)
            request.predicate = NSPredicate(format: "date = %@", date as CVarArg)
            
            do {
                let fetchedToDoList = try context.fetch(request)
                
                if var targetTodo = fetchedToDoList.first {
                    targetTodo = newToDoData
                    appDelegate?.saveContext()
                    completion()
                }
            } catch {
                print("update 실패")
            }
        }
    }
}
