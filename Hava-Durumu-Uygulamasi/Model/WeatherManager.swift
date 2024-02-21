//
//  WeatherManager.swift
//  Hava-Durumu-Uygulamasi
//
//  Created by Ejder Dağ on 21.02.2024.
//

import Foundation

struct WeatherManager {
    
    let baseUrl = "https://api.openweathermap.org/data/2.5/weather?appid=6f0120daf2269fe9d94ce9e08cbef8be&units=metric"
    
    func fetchWeather(for city: String) {
        let urlString = "\(baseUrl)&q=\(city)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) {(data,response,error) in
                
                if error != nil {
                    print(error!.localizedDescription)
                    return
                }
                
                if let safeData = data {

                    let weatherData = parseJson(data: safeData)
                    print("\(weatherData?.main.temp ?? 0.0)")
                }
                
            }
            task.resume()
        }
        
    }
    
    func parseJson(data: Data) -> WeatherData? {
        
        let decoder = JSONDecoder()
        do {
            
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            return decodedData
        } catch {
            print("Decoding Hatası: \(error.localizedDescription)")
            return nil
        }
        
    }
}
