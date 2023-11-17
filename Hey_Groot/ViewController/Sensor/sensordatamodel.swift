//
//  SensorDataModel.swift
//  Hey_Groot
//
//  Created by 김경민 on 11/17/23.
//

import Foundation

// SensorDataModel.swift

import Foundation

struct YourDataModel: Codable {
    let datas: [SensorData]

    struct SensorData: Codable {
        let partner_id: Int
        let date: String
        let light: Double
        let humid: Double
        let temp: Double
        let soil: Int
    }
}
