//
//  CharacterGridViewController.swift
//  CharacterViewerApp
//
//  Created by Nate Jackson on 2/28/18.
//  Copyright © 2018 Nate Jackson. All rights reserved.
//

import UIKit

class CharacterGridViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var gridCollectionView: UICollectionView!
    var listModel: CharacterModelInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 1
        
        if let model = listModel {
            if model.characterCollection.count > 0 {
                count = model.characterCollection.count
            }
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var aCharacter: CharacterInterface
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gridCellID", for: indexPath) as! CharacterGridCollectionViewCell
        
        if indexPath.row < (listModel?.characterCollection.count)! {
            aCharacter = (listModel?.characterCollection[indexPath.row])!
            
            if !aCharacter.isImageLoaded && aCharacter.imageUrl.count > 0 {
                listModel?.loadPhoto(forCharacter: aCharacter, completion: { (picture, error) in
                    guard error == nil else {
                        return
                    }
                    aCharacter.isImageLoaded = true
                    aCharacter.photo        = picture
                    cell.photo?.image       = picture
                })
            }
            else if aCharacter.imageUrl.count == 0 {
                cell.photo?.image = UIImage(named: "Cylon")
            }
            else {
                cell.photo?.image = aCharacter.photo
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetail", sender: indexPath)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let index = sender as? IndexPath {
                let characterDetailVC = segue.destination as! DetailViewController
                let selectedCharacter = listModel?.characterCollection[index.row]
                characterDetailVC.detailModel.characterDO = selectedCharacter
            }
        }
    }
}
