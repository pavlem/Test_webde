//
//  WeatherListTVC.swift
//  TestWebDe
//
//  Created by Pavle Mijatovic on 01/02/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import UIKit

class WeatherListTVC: UITableViewController {
    
    // MARK: - API
    var cityName: String?
    
    // MARK: - Properties
    private var dataTask: URLSessionDataTask?
    private var days = [WeatherPerDay]()
    private var weatherFiveDaysResponseList = [WeatherFiveDaysResponseList]()
    private var navTitle: String?
    // MARK: Calculated
    private var isFiveDayForecast: Bool {
        return weatherFiveDaysResponseList.count == 0
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        setNavigationBar(isFiveDayForecast: isFiveDayForecast)
        fetchCityWeather(cityName: cityName)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        dataTask?.cancel()
    }
    
    // MARK: - Helper
    private func setNavigationBar(isFiveDayForecast: Bool) {
        if isFiveDayForecast {
            setSegmentedControll()
        } else {
            navigationItem.title = "Day \(navTitle ?? "")"
        }
    }
    
    private func hideBlocker() {
        DispatchQueue.main.async {
            BlockScreen.hideBlocker()
        }
    }
    
    private func setTableView() {
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.tableFooterView!.isHidden = true
    }
    
    private func setSegmentedControll() {
        let items = ["API", "Local JSON"]
        let segmentedController = UISegmentedControl(items: items)
        segmentedController.selectedSegmentIndex = 0
        segmentedController.addTarget(self, action: #selector(selectSource(_:)), for: .valueChanged)
        navigationItem.titleView = segmentedController
    }
    
    private func handleNoCityFound() {
        AlertHelper.showAlert(txt: "No city Found, please try again") {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func fetchCityWeather(cityName: String?) {
        guard let cityName = cityName else { return }
        
        BlockScreen(title: "Fetching \(cityName) weather").showBlocker {}
        
        dataTask = WeatherFiveDaysService().getFiveDayData(weatherFiveDaysReq: WeatherFiveDaysReq(cityName: cityName), completion: { [weak self] (weatherFiveDaysResponse, serErr) in
            guard let `self` = self else { return }
            sleep(1) // This is just to ilustrate the block screen look and feel while fetching weather data
            self.days = WeatherPerDay.handle(wList: weatherFiveDaysResponse!.list)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            self.hideBlocker()
        })
    }
    
    // MARK: - Actions
    @objc func selectSource(_ segmentedControl: UISegmentedControl) {
        switch WeatherSourceSwitch(rawValue: segmentedControl.selectedSegmentIndex) {
        case .api:
            fetchCityWeather(cityName: self.cityName)
        case .localJSON:
            WeatherFiveDaysService().getMocFiveDayData { (weatherFiveDaysResponse) in
                self.days = WeatherPerDay.handle(wList: weatherFiveDaysResponse.list)
                tableView.reloadData()
            }
        default:
            break
        }
    }
}

// MARK: - Table view data source
extension WeatherListTVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.days.count > 0 {
            return self.days.count
        } else {
            return weatherFiveDaysResponseList.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherListCell_ID", for: indexPath) as! WeatherListCell
        
        if days.count > 0 {
            cell.weatherListVM = WeatherListVM(weatherPerDay: days[indexPath.row])
        } else {
            cell.weatherListVM = WeatherListVM(weatherPerDay: weatherFiveDaysResponseList[indexPath.row])
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if days.count > 0 {
            let wListTVC = UIStoryboard.weatherListTVC
            wListTVC.weatherFiveDaysResponseList = days[indexPath.row].valuesPer3HourPeriod
            wListTVC.navTitle = days[indexPath.row].day
            self.navigationController?.pushViewController(wListTVC, animated: true)
        } else {
            let wDetailVC = UIStoryboard.weatherDetailVC
            wDetailVC.weatherPerHourFrame = weatherFiveDaysResponseList[indexPath.row]
            self.navigationController?.pushViewController(wDetailVC, animated: true)
        }
    }
}
