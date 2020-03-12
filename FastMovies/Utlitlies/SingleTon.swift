//
//  SingleTon.swift
//  FastMovies
//
//  Created by Taha Muneeb on 16/01/2020.
//  Copyright © 2020 FastOrder. All rights reserved.
//

import Foundation
import CoreData

class SingleTon {
    static var shared = SingleTon()

    var cdContext: NSManagedObjectContext!
    var storeDescriptions: [NSPersistentStoreDescription]!

    init() {
        DispatchQueue.main.async {
            self.cdContext = Constants.appDelegate?.persistentContainer.viewContext

        }

    }

}
