//
//  DetailViewController.swift
//  CharacterViewerApp
//
//  Created by Nate Jackson on 2/28/18.
//  Copyright © 2018 Nate Jackson. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, CharacterDetailModelDidChangedDelegate {

    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterPhoto: UIImageView!
    @IBOutlet weak var characterDescription: UITextView!

    var detailModel = CharacterDetailModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailModel.delegate = self
        characterName.text = detailModel.characterDO?.name
        
        if let isLoaded = detailModel.characterDO?.isImageLoaded {
            if isLoaded {
                characterPhoto.image = detailModel.characterDO?.photo
            }
            else {
                detailModel.upDatePhoto()
            }
        }
        characterDescription.text = detailModel.characterDO?.characterDesc
        
        navigationItem.title = detailModel.characterDO?.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func detailModelDidChanged()-> Void {
        if (detailModel.characterDO?.isImageLoaded)! {
            characterPhoto.image = detailModel.characterDO?.photo
        }
    }
}

