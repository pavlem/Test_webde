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
            sleep(1)
            self.hideBlocker()
            //            guard let weatherFiveDaysResponse = weatherFiveDaysResponse else { return }
            //            for wData in weatherFiveDaysResponse.list {
            //                print(wData.dt_txt)
            //            }
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
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherListCell_ID", for: indexPath)
        cell.textLabel?.text = cityName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let wDetailVC = UIStoryboard.weatherDetailVC
        self.navigationController?.pushViewController(wDetailVC, animated: true)
    }
}
