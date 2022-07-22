//
//  UserScore.swift
//  LeadsdoitAleskeienkoTestAppSwift
//
//  Created by alekseienko on 21.07.2022.
//

import Foundation



class UserScore {
    
    func setScores(value: Int) {
        UserDefaults.standard.set(value, forKey: "userScore")
        UserDefaults.standard.synchronize()
    }
    
    func getScore() -> Int {
       return UserDefaults.standard.integer(forKey: "userScore")
    }
    
    func setupScore() {
        UserDefaults.standard.set(10000, forKey: "userScore")
        UserDefaults.standard.synchronize()
    }
    
    
}
