//
//  CityController.swift
//  WeatherApp
//
//  Created by Joni Ryynänen on 01/10/2018.
//  Copyright © 2018 Joni Ryynänen. All rights reserved.
//

import UIKit

class CityController: UITableViewController {
    
    var data = ["Use GPS"]
    var editOn : Bool = false
    var weatherModel : WeatherModel?
    var selection = "Use GPS"
    var selectionCell : IndexPath = [0,0]
    
    @IBOutlet weak var newCity: UITextField!
    @IBAction func add(_ sender: Any) {
        if(!(newCity.text?.isEmpty)!) {
            let city = newCity.text!
            if(!data.contains(city)) {
                data.append(city)
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: [IndexPath(row: self.data.count-1, section: 0)], with: .automatic)
                self.tableView.endUpdates()
                newCity.text = ""
                handleFile()
            }
        }
    }
    @IBOutlet weak var editButton: UIButton!
    @IBAction func editButton(_ sender: Any) {
        if(editOn) {
            self.editButton.setTitle("Done", for: .normal)
            self.editOn = false
            self.tableView.setEditing(true, animated: true)
        } else {
            self.editButton.setTitle("Edit", for: .normal)
            self.editOn = true
            self.tableView.setEditing(false, animated: false)
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.weatherModel = appDelegate.weatherModel
        self.tableView.selectRow(at: selectionCell, animated: false, scrollPosition: .none)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(!(indexPath.row == 0)) {
            self.weatherModel?.usingGPS = false
        } else {
            self.weatherModel?.usingGPS = true
        }
        self.weatherModel?.city = data[indexPath.row]
        selectionCell = [0,indexPath.row]
        
        
       
    }

    override func tableView (_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "test", for: indexPath)
        cell.textLabel!.text = self.data[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.data.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            handleFile()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        self.tableView.selectRow(at: selectionCell, animated: false, scrollPosition: .none)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func handleFile() {
    
    let file = "cities.txt" 
    var text : String = ""

    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        
        let fileURL = dir.appendingPathComponent(file)
        
            do {
                let text2 = try String(contentsOf: fileURL, encoding: .utf8)
                let lines : [String] = text2.components(separatedBy: "\n")
                
                data.forEach { (item) in
                    if(!item.isEmpty) {
                        text.append("\(item)\n")
                    }
                }
                try text.write(to: fileURL, atomically: false, encoding: .utf8)
            }
            catch {}
        
    }
    }
    
    func initData() {
        
        let file = "cities.txt"
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let fileURL = dir.appendingPathComponent(file)
            
            do {
                let text2 = try String(contentsOf: fileURL, encoding: .utf8)
                let lines : [String] = text2.components(separatedBy: "\n")

                lines.forEach { (item) in
                    if(!item.isEmpty && item != "Use GPS") {
                        data.append(item)
                    }
                }
            }
            catch {}
            
        }
    }
    
}

