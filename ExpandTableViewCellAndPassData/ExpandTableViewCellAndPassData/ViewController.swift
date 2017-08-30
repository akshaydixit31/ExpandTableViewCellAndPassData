//
//  ViewController.swift
//  ExpandTableViewCellAndPassData
//
//  Created by Appinventiv Technologies on 30/08/17.
//  Copyright © 2017 Appinventiv Technologies. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//------------------ Outlet's Of UI's --------------
    @IBOutlet weak var expendedTableView: UITableView!
    
//------------------ Variable Declaration ---------
    let itemInList = ["Bike's","BiCycle","Car's"]
    let bikeArray = ["Accura","Ducati Bikes","Hero","Honda","TVS","Yamaha"]
    let bicycleArray = ["Avon","Atlas","Hero","Montra","Suncross"]
    let cars = ["Audi","BMW","Ford","Maruti"]
    var expandedSections : NSMutableSet = []
    var clickOnButton = false
    var cellIndex = 0
//------------------ ViewDidLoad method -----------
    override func viewDidLoad() {
        super.viewDidLoad()
        expendedTableView.dataSource = self
        expendedTableView.delegate = self
        
    }
//------------ Action for cell Button -------------
    @IBAction func expendedButtonOnCell(_ sender: UIButton) {
        print("section Tapped")
        let section = sender.tag
        print(section)
        let shouldExpand = !expandedSections.contains(section)
        if (shouldExpand) {
            expandedSections.removeAllObjects()
            expandedSections.add(section)
        } else {
            expandedSections.removeAllObjects()
        }
        self.expendedTableView.reloadData()
    }
    
}
//====================== Extention of UIViewController for tableView method's ========================
extension ViewController: UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int{    //------- sections------
        return itemInList.count
    }
//================ For header ==============
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? { //------- Headerview-
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExpendedCell") as? ExpendedCell
            else{
                fatalError()
                }
        cell.expendedButtonOnCell.backgroundColor = UIColor.brown
        cell.expendedButtonOnCell.tag = section
        cell.expendedButtonOnCell.isUserInteractionEnabled = true
        if (expandedSections.contains(section)) {    // ----- for changing button image on click..........
            cell.imageOnButton.image = UIImage(named: "up")
        } else {
            cell.imageOnButton.image = UIImage(named: "down")
        }
        cell.expendedButtonOnCell.setTitle(itemInList[section], for: .normal)
        return cell.contentView
    }
//------ Hieght of header cell ----------------------------
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 72
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
//====================== Method's for cell =================
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(expandedSections.contains(section)) {
            switch section {
            case 0:
                return bikeArray.count
            case 1:
                return bicycleArray.count
            default:
                return cars.count
            }
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExpendedCell", for: indexPath) as? ExpendedCell else{
            fatalError()
        }
        
        cell.expendedButtonOnCell.isUserInteractionEnabled = false
        //    ==================
        switch indexPath.section {
        case 0:
            cell.expendedButtonOnCell.setTitle(bikeArray[indexPath.row], for: .normal)
        case 1:
            cell.expendedButtonOnCell.setTitle(bicycleArray[indexPath.row], for: .normal)
        default:
             cell.expendedButtonOnCell.setTitle(cars[indexPath.row], for: .normal)
        }
        return cell
    }
}

//==================== Class for cell ==================
class ExpendedCell: UITableViewCell {
//--------------- Outlet's Of UI element's------------
    @IBOutlet weak var expendedButtonOnCell: UIButton!
    @IBOutlet weak var imageOnButton: UIImageView!
    
}

