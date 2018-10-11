//
//  DaysController.swift
//  WeatherApp
//
//  Created by Joni Ryynänen on 01/10/2018.
//  Copyright © 2018 Joni Ryynänen. All rights reserved.
//

import UIKit

class DaysController: UITableViewController {
    
    var data = [String]()
    var data2 = [String]()
    var daysWeather : DaysWeather?
    var weatherModel : WeatherModel?
    var timer : Timer!
    var proceed : Bool = false
    var fetching : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.weatherModel = appDelegate.weatherModel
        


                        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    @objc func update() {
        
        if(!fetching) {
            if(self.weatherModel?.usingGPS)! {
                if(self.weatherModel?.coordinates != nil) {
                    
                }
            } else if(!(self.weatherModel?.city.isEmpty)!) {
                fetchUrlCity(city: (self.weatherModel?.city)!)
            }
        }

        
      if(self.data.count >= 40 ) {
            proceed = true
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
            self.timer.invalidate()
        }

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    override func tableView (_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "test", for: indexPath) as! CustomTableViewCell
        

        if(proceed) {
            let icon = (self.daysWeather?.list?[indexPath.row].weather![0].icon!)!
           cell.icon?.image = UIImage(named: "icons/\(icon).png")
            cell.bottom.text = self.data[indexPath.row]
            cell.top.text = self.data2[indexPath.row]
         
        }
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func fetchUrlCity(city : String) {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let url : URL? = URL(string: "http://api.openweathermap.org/data/2.5/forecast?q=Tampere&APPID=a703ba05d58171564102b2db7b9bb014")
        let task = session.dataTask(with: url!, completionHandler: doneFetchingCity);
        
        task.resume();
    }
    
    func doneFetchingCity(data: Data?, response: URLResponse?, error: Error?) {
        
        do {
            let weatherData = try JSONDecoder().decode(DaysWeather.self, from: data!)
            self.daysWeather = weatherData
            let size = (weatherData.list?.count)! - 1
            for i  in 0...size {
                self.data.append(weatherData.list![i].dt_txt!)
                let desc = weatherData.list![i].weather![0].main!
                let heat = Utils.kelvinToCelsius(degrees: (weatherData.list![i].main?.temp)!)
                self.data2.append("\(desc) \(heat) °C")
            }
 
        } catch {
            print(error)
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

       /* self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
 */
        
    }
    
    
}
