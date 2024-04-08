//
//  LikedMusicData+CoreDataProperties.swift
//  MusicApp
//
//  Created by Youngbin Choi on 4/8/24.
//
//

import Foundation
import CoreData


extension LikedMusicData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LikedMusicData> {
        return NSFetchRequest<LikedMusicData>(entityName: "LikedMusicData")
    }

    @NSManaged public var songName: String?
    @NSManaged public var artistName: String?
    @NSManaged public var albumName: String?
    @NSManaged public var previewUrl: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var releaseDateString: String?

}

extension LikedMusicData : Identifiable {

}
