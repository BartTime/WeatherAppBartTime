//
//  FooterTableViewCell.swift
//  WeatherAppForPractice
//
//  Created by Alex on 20.06.2022.
//

import UIKit

class FooterTableViewCell: UITableViewCell {


    @IBOutlet weak var maxDegreeLabel: UILabel!
    @IBOutlet weak var minDegreeLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
