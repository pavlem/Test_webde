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
    private var daysWeather = [WeatherPerDay]()
    private var hoursWeather = [WeatherFiveDaysResponseList]()
    private var navTitle: String?
    // MARK: Calculated
    private var isFiveDayForecast: Bool {
        return hoursWeather.count == 0
    }
    private var isDaysMode: Bool {
        return self.daysWeather.count > 0
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
            if let serErr = serErr {
                
                switch serErr {
                case .noInternetConnection:
                    AlertHelper.showAlert(txt: "No Internet") {}
                case .custom(let txt):
                    AlertHelper.showAlert(txt: txt) {}
                default:
                    AlertHelper.showAlert(txt: "Something is wrong...") {}
                }
                
                return
            }
            sleep(1) // This is just to ilustrate the block screen look and feel while fetching weather data
            self.daysWeather = WeatherPerDay.handle(wList: weatherFiveDaysResponse!.list)
            
            DispatchQueue.main.async {
                BlockScreen.hideBlocker()
                self.tableView.reloadData()
            }
        })
    }
    
    // MARK: - Actions
    @objc func selectSource(_ segmentedControl: UISegmentedControl) {
        switch WeatherSourceSwitch(rawValue: segmentedControl.selectedSegmentIndex) {
        case .api:
            fetchCityWeather(cityName: self.cityName)
        case .localJSON:
            WeatherFiveDaysService().getMocFiveDayData { (weatherFiveDaysResponse) in
                self.daysWeather = WeatherPerDay.handle(wList: weatherFiveDaysResponse.list)
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
        if isDaysMode {
            return daysWeather.count
        } else {
            return hoursWeather.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherListCell_ID", for: indexPath) as! WeatherListCell
        
        if isDaysMode {
            cell.weatherListVM = WeatherListVM(weatherPerDay: daysWeather[indexPath.row])
        } else {
            cell.weatherListVM = WeatherListVM(weatherPerHour: hoursWeather[indexPath.row])
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isDaysMode {
            let wListTVC = UIStoryboard.weatherListTVC
            wListTVC.hoursWeather = daysWeather[indexPath.row].valuesPer3HourPeriod
            wListTVC.navTitle = daysWeather[indexPath.row].day
            self.navigationController?.pushViewController(wListTVC, animated: true)
        } else {
            let wDetailVC = UIStoryboard.weatherDetailVC
            wDetailVC.weatherPerThreeHour = hoursWeather[indexPath.row]
            self.navigationController?.pushViewController(wDetailVC, animated: true)
        }
    }
}
