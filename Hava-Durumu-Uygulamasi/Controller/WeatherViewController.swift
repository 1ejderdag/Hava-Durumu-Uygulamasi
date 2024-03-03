//
//  ViewController.swift
//  Hava-Durumu-Uygulamasi
//
//  Created by Ejder Dağ on 30.01.2024.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var tempDegreeLbl: UILabel!
    @IBOutlet weak var conditionImage: UIImageView!
    @IBOutlet weak var searchTxtFld: UITextField!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherManager.delegate = self
        searchTxtFld.delegate = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // location permission alert
        locationManager.requestLocation() // Konum bilgisini bir seferlik almak için kullanılır. Konum bilgisini sürekli almak için startUpdatingLocation() metodu kullan.
    }
}

//MARK: - UITextFieldDelegate
extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        //print("searchButtonClicked çalıştı")
        searchTxtFld.endEditing(true)  //endEditing(true) olduğunda textFieldDidEndEditing tetiklenir.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //print("textFieldShouldReturn çalıştı")
        searchTxtFld.endEditing(true) // Enter'a basıldığında düzenlemeyi sonlandır ve textFieldDidEndEditing tetikler.
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool { // textField düzenlemesinin sonlandırması tetiklendi. Onaylama bu metot ile sağlanır. Bu metot true dönerse textFieldDidEndEditing tetiklenir.
        //print("textFieldShouldEndEditing çalıştı")
        if searchTxtFld.text != "" {
            return true
        } else {
            searchTxtFld.placeholder = "type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //print("textFieldDidEndEditing çalıştı")
        if let city = searchTxtFld.text {
            weatherManager.fetchWeather(for: city)
        }
        searchTxtFld.text = ""
    }
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        
        DispatchQueue.main.async {
            self.tempDegreeLbl.text = weather.temperatureString
            self.conditionImage.image = UIImage(systemName: weather.conditionName)
            self.cityLbl.text = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        //print(error.localizedDescription)
        print("Bir Hata Oluştu")
    }
    
    
}

//MARK: - CLLocatinManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    
    @IBAction func locationButtonClicked(_ sender: UIButton) {
        //print("locationButtonClicked")
        locationManager.requestLocation() // didUpdateLocations metodunu tetikler.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
}

