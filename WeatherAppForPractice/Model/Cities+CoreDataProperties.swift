//
//  Cities+CoreDataProperties.swift
//  WeatherAppForPractice
//
//  Created by Alex on 23.06.2022.
//
//

import Foundation
import CoreData


extension Cities {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cities> {
        return NSFetchRequest<Cities>(entityName: "Cities")
    }

    @NSManaged public var city: String?
    @NSManaged public var id: Int16

}

extension Cities : Identifiable {

}
