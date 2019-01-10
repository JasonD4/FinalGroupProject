//
//  PokemonDetailedViewController.swift
//  TeamWork (Jason & Olimpia)
//
//  Created by Olimpia on 1/9/19.
//  Copyright © 2019 Olimpia. All rights reserved.
//

import UIKit

class PokemonDetailedViewController: UIViewController {
    
    var pokemonCards: Pokemon!{
        didSet{
            DispatchQueue.main.async {
            self.PokemonDetailCollection.reloadData()
            }
        }
    }

    @IBOutlet weak var pokemonImage: UIImageView!
    
    @IBOutlet weak var PokemonDetailCollection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PokemonDetailCollection.dataSource = self
        view.isOpaque = false
}
    

    @IBAction func pokemonDismiss(_ sender: UIButton) {
        sender.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        dismiss(animated: true, completion: nil)
    }
    

}



extension PokemonDetailedViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonCards!.attacks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonDetailCell", for: indexPath) as? PokemonDetailCell else{return UICollectionViewCell()}
        let attacks = pokemonCards.attacks[indexPath.row]
        cell.skillName.text = attacks.name
        cell.skillPower.text = attacks.damage
        if attacks.text != ""{
        cell.skillDetail.text = attacks.text
            cell.skillDetail.isEditable = false
        }
        else{
            cell.skillDetail.text = nil
            cell.skillDetail.backgroundColor = .clear
        }
        
        ImageHelper.shared.fetchImage(urlString: pokemonCards.imageUrlHiRes) { (appError, image) in
            if let error = appError{
                print(error)
            }
            if let pic = image{
                DispatchQueue.main.async {
                self.pokemonImage.image = pic
                }
            }
        }
        
        
        
        
        return cell
                }
        
    }

