//
//  CoreDataManger.swift
//  MusicApp
//
//  Created by Youngbin Choi on 4/8/24.
//

import Foundation
import UIKit
import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init(){}
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    let modelName = "LikedMusicData"
    
    
    // MARK: - Read
    
    func getMusicFromCoreData() -> [LikedMusicData] {
        
        var likedMusicList : [LikedMusicData] = []
        
        if let context = context {
            let request = NSFetchRequest<LikedMusicData>(entityName: modelName)
            request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
            
            do {
                let fetchedMusicList = try context.fetch(request)
                likedMusicList = fetchedMusicList
            } catch {
                print("fetch 실패")
            }
        }
        return likedMusicList
    }
    
    // MARK: - Create
    
    func saveLikedMusicData(music: Music) {
        
        if LikedCheck(music: music) == true {
            return
        }
        
        if let context = context {
            
            if let entity = NSEntityDescription.entity(forEntityName: modelName, in: context) {
                if let likedMusicData = NSManagedObject(entity: entity, insertInto: context) as? LikedMusicData {
                    likedMusicData.albumName = music.albumName
                    likedMusicData.artistName = music.artistName
                    likedMusicData.date = Date()
                    likedMusicData.imageUrl = music.imageUrl
                    likedMusicData.releaseDateString = music.releaseDateString
                    likedMusicData.songName = music.songName
                }
                do {
                    try context.save()
                } catch {
                    print("save 실패")
                }
            }
        }
    }
    
    // MARK: - LikedCheck
    
    func LikedCheck(music: Music) -> Bool {
        
        guard let songName = music.songName, let albumName = music.albumName else { return false }
        
        if let context = context {
            let request = NSFetchRequest<LikedMusicData>(entityName: modelName)
            // predicate multiple condition
            let predicate1 = NSPredicate(format: "songName == %@", songName as CVarArg)
            let predicate2 = NSPredicate(format: "albumName == %@", albumName as CVarArg)
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1, predicate2])
            
            do {
                let fetchedData = try context.fetch(request)
                if !fetchedData.isEmpty {
                    return true
                } else {
                    return false
                }
            } catch {
                print("predicate 실패")
            }
            
        }
        return false
    }
    
    // MARK: - Delete
    
    func deleteLikedMusic(music: LikedMusicData) {
        
        guard let songName = music.songName, let albumName = music.albumName else { return }
        
        if let context = context {
            let request = NSFetchRequest<LikedMusicData>(entityName: modelName)
            // predicate multiple condition
            let predicate1 = NSPredicate(format: "songName == %@", songName as CVarArg)
            let predicate2 = NSPredicate(format: "albumName == %@", albumName as CVarArg)
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1, predicate2])
            
            do {
                let fetchedList = try context.fetch(request)
                if let targetMusic = fetchedList.first {
                    context.delete(targetMusic)
                    appDelegate?.saveContext()
                }
            } catch {
                print("delete 실패")
            }
        }
    }
}


