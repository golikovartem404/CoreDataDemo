//
//  Person+CoreDataProperties.swift
//  CoreData-Names
//
//  Created by User on 13.11.2022.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var dateOfBirth: Date?
    @NSManaged public var gender: String?
    @NSManaged public var image: Data?

}

extension Person : Identifiable {

}
