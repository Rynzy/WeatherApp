//
//  CurrentController.swift
//  WeatherApp
//
//  Created by Joni Ryynänen on 01/10/2018.
//  Copyright © 2018 Joni Ryynänen. All rights reserved.
//

import UIKit
import Foundation

class CurrentController: UIViewController {
    
    var currentWeather : CurrentWeather?
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var degreesLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchUrl(url: "http://api.openweathermap.org/data/2.5/weather?q=Tampere&APPID=a703ba05d58171564102b2db7b9bb014")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
    func fetchUrl(url : String) {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let url : URL? = URL(string: url)
        let task = session.dataTask(with: url!, completionHandler: doneFetching);

        task.resume();
    }
    
    func doneFetching(data: Data?, response: URLResponse?, error: Error?) {
       //let resstr = String(data: data!, encoding: String.Encoding.utf8)
      
        do {
            let weatherData = try JSONDecoder().decode(CurrentWeather.self, from: data!)
            self.currentWeather = weatherData
            
        } catch {
            print(error)
        }
        
        DispatchQueue.main.async(execute: {() in
            self.cityLabel.text = self.currentWeather?.name!
            self.degreesLabel.text = "\(Utils.kelvinToCelsius(degrees: self.currentWeather!.main!.temp!)) C"
        })
        
    }

}
