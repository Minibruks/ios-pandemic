//
//  PandemicInfo.swift
//  vk-job
//
//  Created by Павел on 09.05.2023.
//

import Foundation


class PandemicInfo {
    private var groupSize: Int
    private var infectionFactor: Int
    private var firstCellSelected: Bool
    public var tmp = [Bool]()
    public var infectedSize = 0
    
    init() {
        self.groupSize = 0
        self.infectionFactor = 0
        self.firstCellSelected = false
    }
    
    public func getGroupSize() -> Int {
        return groupSize
    }
    
    public func getInfectionFactor() -> Int {
        return infectionFactor
    }
    
    public func setGroupSize(newGroupSize: Int) {
        for _ in 0...(newGroupSize - 1) {
            tmp.append(false)
        }
        self.groupSize = newGroupSize
    }
    
    public func setInfectionFactor(newInfectionFactor: Int) {
        self.infectionFactor = newInfectionFactor
    }
    
    public func setFirstCellSelected(newFirstCellSelected: Bool) {
        self.firstCellSelected = newFirstCellSelected
    }
    
    public func getFirstCellSelected() -> Bool {
        return firstCellSelected
    }
}
