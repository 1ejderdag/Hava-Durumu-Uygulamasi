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
    }

    @IBAction func searchButtonClicked(_ sender: UIButton) {
    }
    @IBAction func locationButtonClicked(_ sender: UIButton) {
    }
}

