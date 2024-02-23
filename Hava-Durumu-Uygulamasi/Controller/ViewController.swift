//
//  ViewController.swift
//  Hava-Durumu-Uygulamasi
//
//  Created by Ejder Dağ on 30.01.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var tempDegreeLbl: UILabel!
    @IBOutlet weak var conditionImage: UIImageView!
    @IBOutlet weak var searchTxtFld: UITextField!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherManager.fetchWeather(for: "Elazig")
        searchTxtFld.delegate = self
    }

    @IBAction func locationButtonClicked(_ sender: UIButton) {
    }
}

//MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        searchTxtFld.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTxtFld.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTxtFld.text != "" {
            return true
        } else {
            searchTxtFld.placeholder = "type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTxtFld.text {
            weatherManager.fetchWeather(for: city)
        }
        searchTxtFld.text = ""
    }
}

//MARK: - WeatherManagerDelegate

extension ViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        
        DispatchQueue.main.async {
            self.tempDegreeLbl.text = weather.temperatureString
            self.conditionImage.image = UIImage(systemName: weather.conditionName)
            self.cityLbl.text = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
    
    
}

//MARK: - CLLocatinManagerDelegate


