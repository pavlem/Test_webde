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

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSegmentedControll()
        setTableView()
//        handleNoCityFound()
        
        if let cityName = cityName {
            fetchCityWeather(cityName: cityName)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        dataTask?.cancel()
    }
    
    // MARK: - Helper
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
    
    private func fetchCityWeather(cityName: String) {
        BlockScreen(title: "Fetching \(cityName) weather").showBlocker {}
        
        dataTask = WeatherFiveDaysServer().getFiveDayData(weatherFiveDaysReq: WeatherFiveDaysReq(cityName: cityName), completion: { [weak self] (weatherFiveDaysResponse, serErr) in
            guard let `self` = self else { return }
//            sleep(1)
            self.days = WeatherPerDay.handle(wList: weatherFiveDaysResponse!.list)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            self.hideBlocker()
        })
    }
    
    // MARK: - Actions
    @objc func selectSource(_ segmentedControl: UISegmentedControl) {
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            print("API")
        case 1:
            print("JSON....")
        default:
            print("default....")
        }
    }
}

// MARK: - Table view data source
extension WeatherListTVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.days.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherListCell_ID", for: indexPath) as! WeatherListCell
        cell.weatherListVM = WeatherListVM(weatherPerDay: days[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let wDetailVC = UIStoryboard.weatherDetailVC
        wDetailVC.weatherPerDay = days[indexPath.row]
        self.navigationController?.pushViewController(wDetailVC, animated: true)
    }
}
