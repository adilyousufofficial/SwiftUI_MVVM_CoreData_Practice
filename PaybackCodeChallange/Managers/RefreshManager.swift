//
//  RefreshManager.swift
//  PaybackCodeChallange
//
//  Created by **** on 29/08/2022.
//

import Foundation

class RefreshManager: NSObject {
    
    static let shared = RefreshManager()
    private let defaults = UserDefaults.standard
    private let defaultsKey = "lastRefresh"
    private let calender = Calendar.current
    
    func loadDataIfNeeded(completion: (Bool) -> Void) {
        
        if isRefreshRequired() {
            defaults.set(Date(), forKey: defaultsKey)
            completion(true)
        } else {
            completion(false)
        }
    }
    
    private func isRefreshRequired() -> Bool {
        
        guard let lastRefreshDate = defaults.object(forKey: defaultsKey) as? Date else {
            return true
        }
        
        if let diff = calender.dateComponents([.day], from: lastRefreshDate, to: Date()).day, diff >= 1 {
            return true
        } else {
            return false
        }
    }
}
