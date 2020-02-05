//
//  WeatherListCell.swift
//  TestWebDe
//
//  Created by Pavle Mijatovic on 01/02/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import UIKit

class WeatherListCell: UITableViewCell {
    
    // MARK: - API
    var weatherListVM: WeatherListVM? {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - Properties
    // MARK: Outlets
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var avgTempLbl: UILabel!
    @IBOutlet weak var startTimeLbl: UILabel!
    @IBOutlet weak var weatherIconImgView: UIImageView!
    // MARK: Vars
    private var dataTask: URLSessionDataTask?

    // MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }
    
    // MARK: Private
    private func setUI() {
        dayLbl.font = UIFont.boldSystemFont(ofSize: 16)
        avgTempLbl.font = UIFont.systemFont(ofSize: 16)
        startTimeLbl.font = UIFont.systemFont(ofSize: 16)
    }
    
    private func updateUI() {
        dayLbl.text = weatherListVM?.day
        avgTempLbl.text = weatherListVM?.averageTemp
        startTimeLbl.text = weatherListVM?.startingTime
        
        if let iconString = weatherListVM?.iconString {
            setIcon(iconCode: iconString)
        }
    }
    
    private func setIcon(iconCode: String) {
        self.dataTask = WeatherImageService().getWeatherIcon(iconCode: iconCode) { (image, serErr) in
            guard serErr == nil else { return }
            guard let img = image else { return }
            
            DispatchQueue.main.async() {
                self.weatherIconImgView.image = img
            }
        }
    }

    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}


