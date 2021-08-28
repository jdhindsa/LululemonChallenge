//
//  PersistenceManager.swift
//  LululemonChallenge
//
//  Created by Jason Dhindsa on 2021-08-28.
//

import Foundation

enum PersistenceManager {
    static func loadDataFromUserDefaults() -> [JDGarment] {
        var loaded: [JDGarment] = []
        let defaults = UserDefaults.standard
        
        if let savedGarments = defaults.object(forKey: "SavedGarments") as? Data {
            let decoder = JSONDecoder()
            if let loadedGarments = try? decoder.decode([JDGarment].self, from: savedGarments) {
                loaded = loadedGarments
            }
        }
        return loaded
    }
    
    static func saveDataToUserDefaults(viewModels: [JDGarmentViewModel]?) {
        guard let viewModels = viewModels else { return }
        var garments = [JDGarment]()
        for viewModel in viewModels {
            garments.append(JDGarment(garmentName: viewModel.garmentName, creationDate: viewModel.creationDate))
        }
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(garments) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "SavedGarments")
        }
    }
}
