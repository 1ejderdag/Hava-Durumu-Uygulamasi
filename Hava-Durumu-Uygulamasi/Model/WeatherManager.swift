//
//  WeatherManager.swift
//  Hava-Durumu-Uygulamasi
//
//  Created by Ejder Dağ on 21.02.2024.
//

import Foundation
protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}
struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
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
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {

                    if let weather = self.parseJson(weatherData: safeData) {
                        
                    }
                }
                
            }
            task.resume()
        }
        
    }
    
    func parseJson(weatherData: Data) -> WeatherModel? {
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
}
