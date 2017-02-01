//
//  Image+CoreDataProperties.swift
//  tabbar-journal
//
//  Created by Joel Shin on 2/1/17.
//  Copyright © 2017 Joel Shin. All rights reserved.
//

import Foundation
import CoreData


extension Image {
    /* JWS
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image");
    }*/

    @NSManaged public var title: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var tag: Tag?

}
