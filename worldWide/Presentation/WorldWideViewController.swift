//
//  WorldWideViewController.swift
//  worldWide
//
//  Created by Abdo on 10/18/18.
//  Copyright © 2018 Abdo. All rights reserved.
//

import UIKit

class WorldWideViewController: UIViewController {

    @IBOutlet weak var worldWideTable: UITableView!
    @IBAction func logoutButtonTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    var countries = [Country]()
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO:- Refactor this line(should not be here)
        CountriesRepository.getAllCountriesData { (countries) in
            self.countries = countries
            self.worldWideTable.reloadData()
            
        }
    }


}

extension WorldWideViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = worldWideTable.dequeueReusableCell(withIdentifier: "CountryCellID") as! WorldWideTableViewCell
        cell.countryNameLabel.text = self.countries[indexPath.row].name
        cell.capitalLabel.text = self.countries[indexPath.row].capital
        return cell
    }
    
    
}
