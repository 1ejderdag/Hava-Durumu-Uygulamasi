//
//  WeatherData.swift
//  Hava-Durumu-Uygulamasi
//
//  Created by Ejder Dağ on 21.02.2024.
//

import Foundation

struct WeatherData: Codable {
    let main: Main
}
struct Main: Codable {
    let temp: Double?
}
