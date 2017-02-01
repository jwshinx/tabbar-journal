//
//  Tag+CoreDataProperties.swift
//  tabbar-journal
//
//  Created by Joel Shin on 2/1/17.
//  Copyright © 2017 Joel Shin. All rights reserved.
//

import Foundation
import CoreData


extension Tag {
    /* JWS
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag");
    }*/

    @NSManaged public var title: String?
    @NSManaged public var images: NSSet?

}
/* JWS
// MARK: Generated accessors for images
extension Tag {

    @objc(addImagesObject:)
    @NSManaged public func addToImages(_ value: Image)

    @objc(removeImagesObject:)
    @NSManaged public func removeFromImages(_ value: Image)

    @objc(addImages:)
    @NSManaged public func addToImages(_ values: NSSet)

    @objc(removeImages:)
    @NSManaged public func removeFromImages(_ values: NSSet)

}*/
