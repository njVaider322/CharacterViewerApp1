//
//  MasterViewController.swift
//  CharacterViewerApp
//
//  Created by Nate Jackson on 2/28/18.
//  Copyright © 2018 Nate Jackson. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, CharacterModelDidChangedDelegate {

    var detailViewController: DetailViewController? = nil
    var objects = [Any]()
   
    fileprivate var listModel: CharacterModelInterface = CharacterModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        if UIDevice.current.model.contains("Pad") {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
        
        listModel.delegate = self
        listModel.initializeModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailOne" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let selectedCharacter = listModel.characterCollection[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailModel.characterDO = selectedCharacter
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
        
        if segue.identifier == "showDetailTwo" {
            let characterGridVC = segue.destination as! CharacterGridViewController
            characterGridVC.listModel = listModel
        }
    }

    // MARK: - Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 1;
        
        if (listModel.characterCollection.count > 0) {
            count = listModel.characterCollection.count
        }
        return count;
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let aCharacter: CharacterInterface
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCellID", for: indexPath) as! CharacterListTableViewCell

        if indexPath.row < listModel.characterCollection.count {
            aCharacter      = listModel.characterCollection[indexPath.row]
            cell.name?.text = aCharacter.name
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    // MARK: - Character Model Delegate Methods
    func characterModelDidChanged() {
        self.tableView.reloadData()
    }
}

