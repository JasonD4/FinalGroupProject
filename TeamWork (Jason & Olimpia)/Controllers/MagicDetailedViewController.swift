//
//  MagicDetailedViewController.swift
//  TeamWork (Jason & Olimpia)
//
//  Created by Olimpia on 1/9/19.
//  Copyright © 2019 Olimpia. All rights reserved.
//

import UIKit

class MagicDetailedViewController: UIViewController {
    
  
    var currentCard: MagicCards!{
        didSet{
            DispatchQueue.main.async {
                self.detailedMagicCollection.reloadData()
            }
        }
    }

    @IBOutlet weak var detailedMagicCollection: UICollectionView!
    @IBAction func magicDismis(_ sender: UIButton) {
         dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
detailedMagicCollection.dataSource = self
       
    }
    

    

}

extension MagicDetailedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentCard.foreignNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = detailedMagicCollection.dequeueReusableCell(withReuseIdentifier: "MagicDetailedCell", for: indexPath) as? MagicDetailedCell else { return UICollectionViewCell() }
        cell.CardName.text = currentCard.foreignNames[indexPath.row].name
        cell.language.text = currentCard.foreignNames[indexPath.row].language
        cell.cardAbilties.text = currentCard.foreignNames[indexPath.row].text
        cell.magicDetailedSpinerThingy.stopAnimating()
        
        cell.cardAbilties.isEditable = false
        ImageHelper.shared.fetchImage(urlString: currentCard.foreignNames[indexPath.row].imageUrl) { (error, image) in
            if let error = error {
                print(AppError.errorMessage(error))
            } else if let image = image {
                cell.MagicDetailImage.image = image
            }
            
        }
        return cell
    }
    
    
}
