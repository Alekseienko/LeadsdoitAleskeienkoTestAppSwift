//
//  GameModel.swift
//  LeadsdoitAleskeienkoTestAppSwift
//
//  Created by alekseienko on 05.07.2022.
//

import Foundation


struct SlotModel {
    let name: String
    let isPopular: Bool
    let backgroungImage: String
    let slotImageArray: [String]
    let logoImage: String
    let countLines: Int
    
    func randomSlot() -> Int {
        return Int.random(in: 9...17)
    }
    
    func pikerImageLine() -> [String] {
        var pikerImageLine = [String]()
        for _ in 1...3 {
            pikerImageLine.append(contentsOf: slotImageArray)
        }
        return pikerImageLine
    }
    
    func equalInLine(lineArray: [Int], currentBank: Int,currentBet: Double) -> Int {
        let filter = Set(lineArray).count
        var bank = currentBank
        switch filter {
        case 1:
            // 5 из 5 Однаковых
            bank = bank + Int(currentBet * 10)
        case 2:
            // 4 из 5 Однаковых
            bank = bank + Int(currentBet * 3)
        case 3:
            // 3 из 5 Однаковых
            bank = bank + Int(currentBet * 2)
        case 4:
            // 2 из 5 Однаковых
            bank = bank - Int(currentBet * 0.5)
        case 5:
            // 0 из 5 Однаковых
            bank = bank - Int(currentBet)
        default:
            print("Some error in func equalInLine")
        }
        return bank
    }
    
    func infoLabelText(before: Int, after: Int) -> String {
        let changesBank = after - before
        var infoText: String = ""
        if changesBank > 0 {
            infoText = "WIN: +\(changesBank)"
        } else {
            infoText = "LOSE: \(changesBank)"
        }
        return infoText
    }
}
