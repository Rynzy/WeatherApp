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
    var weatherModel : WeatherModel?
    var apiKey : String = "&APPID=a703ba05d58171564102b2db7b9bb014"
    var baseURL : String = "http://api.openweathermap.org/data/2.5/weather?q="
    var timer : Timer!
    var image : UIImage?

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var degreesLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var activityIndicator: UIView!
    let progress = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.weatherModel = appDelegate.weatherModel
        
        progress.color = UIColor.black
        progress.center =  CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2)

        self.view.addSubview(progress)
        
        
    }
    
    @objc func update() {
        
        if(self.weatherModel?.usingGPS)! {
            if(self.weatherModel?.coordinates != nil) {
                fetchUrlCoordinates(coords: (self.weatherModel?.coordinates)!)
                self.timer.invalidate()
            }
        } else if(!(self.weatherModel?.city.isEmpty)!) {
            fetchUrlCity(city: (self.weatherModel?.city)!)
            self.timer.invalidate()
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
    func fetchUrlCity(city : String) {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let url : URL? = URL(string: "\(baseURL)\(city)\(apiKey)")
        let task = session.dataTask(with: url!, completionHandler: doneFetchingCity);
        task.resume();
        
    }
    
    func doneFetchingCity(data: Data?, response: URLResponse?, error: Error?) {
       //let resstr = String(data: data!, encoding: String.Encoding.utf8)
      
        do {
            let weatherData = try JSONDecoder().decode(CurrentWeather.self, from: data!)
            self.currentWeather = weatherData
            setImage(icon: (self.currentWeather?.weather![0].icon)!)
            
        } catch {
            print(error)
        }
        
        DispatchQueue.main.async(execute: {() in
            self.cityLabel.text = self.currentWeather?.name!
            self.degreesLabel.text = "\(Utils.kelvinToCelsius(degrees: self.currentWeather!.main!.temp!)) C"
        })
        
    }
    
    func fetchUrlCoordinates(coords : Coordinate) {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let lat = (self.weatherModel?.coordinates?.lat!)!
        let lon = (self.weatherModel?.coordinates?.lon!)!
        
        let url : URL? = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)\(apiKey)")
        

        let task = session.dataTask(with: url!, completionHandler: doneFetchingCoordinates);
        
        task.resume();
    }
    
    func doneFetchingCoordinates(data: Data?, response: URLResponse?, error: Error?) {
        //let resstr = String(data: data!, encoding: String.Encoding.utf8)
        
        do {
            let weatherData = try JSONDecoder().decode(CurrentWeather.self, from: data!)
            self.currentWeather = weatherData
            setImage(icon: (self.currentWeather?.weather![0].icon)!)
            
        } catch {
            print(error)
        }
        
       DispatchQueue.main.async(execute: {() in
            self.cityLabel.text = self.currentWeather?.name!
            self.degreesLabel.text = "\(Utils.kelvinToCelsius(degrees: self.currentWeather!.main!.temp!)) C"
        
        })
        
        
    }
    
    func setImage(icon : String) {
        let iconUrl = URL(string: "http://openweathermap.org/img/w/\(icon).png")!
        let session = URLSession(configuration: .default)
        
        print(iconUrl)
        
        let downloadPicTask = session.dataTask(with: iconUrl) { (data, response, error) in
            if let e = error {
                print("Error icon: \(e)")
            } else {
                if let res = response as? HTTPURLResponse {
                    if let imageData = data {
                        let image = UIImage(data: imageData)
                        DispatchQueue.main.async {self.imageLabel.image = image
                            self.progress.stopAnimating()
                        }
                        
                    } else {
                        print("Couldn't get icon: Icon is nil")
                    }
                } else {
                    print("No response")
                }
            }
        }
        
        downloadPicTask.resume()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        progress.startAnimating()
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        
    }

}
