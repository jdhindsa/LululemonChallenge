//
//  JDGarmentViewModel.swift
//  LululemonChallenge
//
//  Created by Jason Dhindsa on 2021-08-28.
//

import Foundation

struct JDGarmentViewModel: Codable {
    var garmentName: String
    var creationDate: Date
    
    // Dependency Injection
    init(garment: JDGarment) {
        self.garmentName = garment.garmentName
        self.creationDate = garment.creationDate
    }
    
    static func saveToUserDefaults(viewModels: [JDGarmentViewModel]?) {
        PersistenceManager.saveDataToUserDefaults(viewModels: viewModels)
    }
    
    static func loadFromUserDefaults() -> [JDGarment] {
        PersistenceManager.loadDataFromUserDefaults()
    }
}
