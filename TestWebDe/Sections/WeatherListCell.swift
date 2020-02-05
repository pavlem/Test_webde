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
    
    // MARK: Properties
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var avgTempLbl: UILabel!
    @IBOutlet weak var startTimeLbl: UILabel!
    @IBOutlet weak var weatherIconImgView: UIImageView!
    


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
        
        guard let url = URL(string: "https://openweathermap.org/img/wn/\(iconCode)@2x.png") else { return }
        getData(from: url) { (data, response, error) in
            
            guard
            let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
            let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
            let data = data, error == nil,
            let image = UIImage(data: data)
            else { return }
            
            DispatchQueue.main.async() {
                self.weatherIconImgView.image = image
            }
        }
    }

    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}

//extension UIImageView {
//    private func downloaded(from url: URL, contentMode mode:  UIView.ContentMode = .scaleToFill) {
//        contentMode = mode
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard
//                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
//                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
//                let data = data, error == nil,
//                let image = UIImage(data: data)
//                else { return }
//            DispatchQueue.main.async() {
//                self.image = image
//            }
//        }.resume()
//    }
//
//    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
//        guard let url = URL(string: link) else { return }
//        downloaded(from: url, contentMode: mode)
//    }
//}
