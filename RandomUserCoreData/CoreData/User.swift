//
//  User+CoreDataClass.swift
//  RandomUserCoreData
//
//  Created by Mykhailo Sorokin on 4/25/19.
//  Copyright © 2019 Mykhailo Sorokin. All rights reserved.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject, Codable {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }
    
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var userName: String?
    @NSManaged public var city: String?
    @NSManaged public var state: String?
    @NSManaged public var email: String?
    @NSManaged public var gender: String?
    @NSManaged public var nat: String?
    @NSManaged public var phone: String?
    @NSManaged public var cell: String?
    @NSManaged public var thumbnailURLString: String?
    @NSManaged public var imageURLString: String?
    @NSManaged public var createdAt: Date
    
    enum NameKeys: String, CodingKey {
        case first
        case last
    }
    
    enum LocationKeys: String, CodingKey {
        case city
        case state
    }
    
    enum PictureKeys: String, CodingKey {
        case large
        case thumbnail
    }
    
    enum LoginKeys: String, CodingKey {
        case username
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case location
        case picture
        case login
        case email
        case gender
        case nat
        case phone
        case cell
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let codableContext = CodingUserInfoKey.init(rawValue: "context"),
            let managedObjectContext = decoder.userInfo[codableContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "User", in: managedObjectContext)
            else { fatalError(" initialization failed") }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let nameContainer = try container.nestedContainer(keyedBy: NameKeys.self, forKey: .name)
        self.firstName = try nameContainer.decodeIfPresent(String.self, forKey: .first)
        self.lastName = try nameContainer.decodeIfPresent(String.self, forKey: .last)
        
        let locationContainer = try container.nestedContainer(keyedBy: LocationKeys.self, forKey: .location)
        self.city = try locationContainer.decodeIfPresent(String.self, forKey: .city)
        self.state = try locationContainer.decodeIfPresent(String.self, forKey: .state)
        
        let pictureContainer = try container.nestedContainer(keyedBy: PictureKeys.self, forKey: .picture)
        self.thumbnailURLString = try pictureContainer.decodeIfPresent(String.self, forKey: .thumbnail)
        self.imageURLString = try pictureContainer.decodeIfPresent(String.self, forKey: .large)
        
        let loginContainer = try container.nestedContainer(keyedBy: LoginKeys.self, forKey: .login)
        self.userName = try loginContainer.decodeIfPresent(String.self, forKey: .username)
        
        self.gender = try container.decodeIfPresent(String.self, forKey: .gender)
        self.nat = try container.decodeIfPresent(String.self, forKey: .nat)
        self.phone = try container.decodeIfPresent(String.self, forKey: .phone)
        self.cell = try container.decodeIfPresent(String.self, forKey: .cell)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.createdAt = Date()
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        var nameContainer = container.nestedContainer(keyedBy: NameKeys.self, forKey: .name)
        try nameContainer.encode(self.firstName, forKey: .first)
        try nameContainer.encode(self.lastName, forKey: .last)
        
        var locationContainer = container.nestedContainer(keyedBy: LocationKeys.self, forKey: .location)
        try locationContainer.encode(self.city, forKey: .city)
        try locationContainer.encode(self.state, forKey: .state)
        
        var pictureContainer = container.nestedContainer(keyedBy: PictureKeys.self, forKey: .picture)
        try pictureContainer.encode(self.imageURLString, forKey: .large)
        try pictureContainer.encode(self.thumbnailURLString, forKey: .thumbnail)
        
        var loginContainer = container.nestedContainer(keyedBy: LoginKeys.self, forKey: .login)
        try loginContainer.encode(self.userName, forKey: .username)
        
        try container.encode(self.gender, forKey: .gender)
        try container.encode(self.nat, forKey: .nat)
        try container.encode(self.phone, forKey: .phone)
        try container.encode(self.cell, forKey: .cell)
        try container.encode(self.email, forKey: .email)
    }
}
