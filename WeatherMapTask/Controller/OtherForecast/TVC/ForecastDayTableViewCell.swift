//
//  ForecastDayTableViewCell.swift
//  WeatherMapTask
//
//  Created by Dheeraj's Mac on 23/09/21.
//

import UIKit

class ForecastDayTableViewCell: UITableViewCell {
    @IBOutlet var weatherConditionImageView: UIImageView!
    @IBOutlet var weekdayLabel: UILabel!
    @IBOutlet var weatherConditionLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
