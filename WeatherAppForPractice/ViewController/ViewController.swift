//
//  ViewController.swift
//  WeatherAppForPractice
//
//  Created by Alex on 17.06.2022.
//

import UIKit

class ViewController: UIViewController {
    var headerWeather: HeaderWeatherModel!
    var mainWeather: MainWeatherModel!
    var footerWeather: WeatherModel!
    
    let apiKey  = "2aed1298172f40bebc63119781e2a83b"
    var city    = "Moscow"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeatherForHeader()
        getWeatherForFooter()
        getWeatherForMainSection()
        createBackground()
    }
    
    func createBackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background")
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else if section == 2{
            return 7
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return ""
        }else if section == 1 {
            return "Прогноз на 24 часа"
        }else{
            return "Прогноз на неделю"
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .black
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 150
        }else if indexPath.section == 1 {
            return 120
        }
        return 52
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = Bundle.main.loadNibNamed("HeaderTableViewCell", owner: self, options: nil)?.first as? HeaderTableViewCell else { return UITableViewCell() }
            
            cell.cityLabel.text     = headerWeather.city_name
            cell.degreesLabel.text  = "\(headerWeather.data[0].temp)℃"
            cell.WeatherLabel.text  = "\(footerWeather.data[0].weather.description)"
            cell.backgroundColor = .clear
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }else if indexPath.section == 2 {
            guard let cell = Bundle.main.loadNibNamed("FooterTableViewCell", owner: self, options: nil)?.first as? FooterTableViewCell else { return UITableViewCell() }
            
            if indexPath.row == 0 {
                cell.dayLabel.text = "Сегодня"
            }else{
                let someDate = footerWeather.data[indexPath.row].valid_date.components(separatedBy: "-")
                cell.dayLabel.text = "\(someDate[2]) число"
            }
            cell.weatherIcon.image    = UIImage(named: footerWeather.data[indexPath.row].weather.icon)
            cell.maxDegreeLabel.text  = "\(footerWeather.data[indexPath.row].max_temp)℃"
            cell.minDegreeLabel.text  = "\(footerWeather.data[indexPath.row].low_temp)℃"
            cell.backgroundColor    = UIColor(cgColor: CGColor(red:  240/255, green: 176/255, blue: 183/255, alpha: 0.6))
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainSection") as? MainTableViewCell else { return UITableViewCell() }
            cell.setupCell(weather: mainWeather)
            cell.backgroundColor    = UIColor(cgColor: CGColor(red:  240/255, green: 176/255, blue: 183/255, alpha: 0.6))
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }

    }
    
    
    func getWeatherForHeader() {
        guard let url = URL(string: "https://api.weatherbit.io/v2.0/forecast/minutely?city=\(city)&key=\(apiKey)") else { return }
        let semaphore = DispatchSemaphore(value: 0)
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else { return }
            guard let data = data else { return }

            do{
                let weatherForHeader  = try JSONDecoder().decode(HeaderWeatherModel.self, from: data)
                self.headerWeather    = weatherForHeader
                semaphore.signal()
            }catch{
                print(error)
            }
        }.resume()
        
        _ = semaphore.wait(timeout: .distantFuture)
        
    }

    
    func getWeatherForFooter(){
        guard let url = URL(string: "https://api.weatherbit.io/v2.0/forecast/daily?city=\(city)&key=\(apiKey)") else { return }
        let semaphore = DispatchSemaphore(value: 0)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else { return }
            guard let data = data else { return }
        
            do {
                let weather         = try JSONDecoder().decode(WeatherModel.self, from: data)
                self.footerWeather  = weather
                semaphore.signal()
            }catch{
                print(error)
            }
        }.resume()
        
        _ = semaphore.wait(timeout: .distantFuture)
    }
    
    
    func getWeatherForMainSection() {
        guard let url = URL(string: "https://api.weatherbit.io/v2.0/forecast/hourly?city=\(city)&key=\(apiKey)&hours=24") else { return }
        let semaphore = DispatchSemaphore(value: 0)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else { return }
            guard let data = data else { return }
            
            do {
                let weather       = try JSONDecoder().decode(MainWeatherModel.self, from: data)
                self.mainWeather  = weather
                semaphore.signal()
            }catch{
                print(error)
            }
            
        }.resume()
        _ = semaphore.wait(timeout: .distantFuture)
    }
    
}



