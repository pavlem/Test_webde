//
//  WeatherListCell.swift
//  TestWebDe
//
//  Created by Pavle Mijatovic on 01/02/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import UIKit

class WeatherListCell: UITableViewCell {
    
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var avgTempLbl: UILabel!
    @IBOutlet weak var startTimeLbl: UILabel!
    @IBOutlet weak var weatherIconImgView: UIImageView!
    
    var weatherListVM: WeatherListVM? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        dayLbl.text = weatherListVM?.day
        avgTempLbl.text = weatherListVM?.averageTemp
        startTimeLbl.text = weatherListVM?.startingTime
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
