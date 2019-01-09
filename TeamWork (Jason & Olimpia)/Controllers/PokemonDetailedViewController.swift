//
//  PokemonDetailedViewController.swift
//  TeamWork (Jason & Olimpia)
//
//  Created by Olimpia on 1/9/19.
//  Copyright © 2019 Olimpia. All rights reserved.
//

import UIKit

class PokemonDetailedViewController: UIViewController {
    var pokemonCards: Pokemon?

    @IBOutlet weak var pokemonImage: UIImageView!
    
    @IBOutlet weak var PokemonDetailCollection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func pokemonDismiss(_ sender: UIButton) {
        
    }
    

}
