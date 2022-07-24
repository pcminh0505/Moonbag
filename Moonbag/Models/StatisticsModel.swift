//
//  StatisticsModel.swift
//  Moonbag
//
//  Created by Minh Pham on 24/07/2022.
//

import Foundation

class StatisticsModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    
    init(title: String, value: String) {
        self.title = title
        self.value = value
    }
}
