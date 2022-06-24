//
//  MainTableViewCell.swift
//  WeatherAppForPractice
//
//  Created by Alex on 21.06.2022.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var someWeather: MainWeatherModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(weather: MainWeatherModel) {
        self.someWeather = weather
        self.collectionView.reloadData()
    }

}

extension MainTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        someWeather.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCell", for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        let weatherForIndexPath  = someWeather.data[indexPath.row]
        let date                 = weatherForIndexPath.timestamp_local.components(separatedBy: "T")
        let time                 = date[1].components(separatedBy: ":")
        
        cell.setupCell(temperature: weatherForIndexPath.app_temp, time: time[0], icon: weatherForIndexPath.weather.icon)

        return cell
    }
    
    
}
