//
//  MainCollectionViewCell.swift
//  WeatherAppForPractice
//
//  Created by Alex on 21.06.2022.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupCell(temperature: Double, time: String, icon: String){
        self.temperatureLabel.text  = "\(temperature)℃"
        self.dayLabel.text          = time
        self.weatherIcon.image      = UIImage(named: icon)
    }
}
