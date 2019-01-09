//
//  PokemonViewController.swift
//  TeamWork (Jason & Olimpia)
//
//  Created by Olimpia on 1/9/19.
//  Copyright © 2019 Olimpia. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    
    var pokemonCard = [Pokemon](){
        didSet{
            DispatchQueue.main.async {
            self.PokemonCollectionView.reloadData()
            }
        }
    }

    @IBOutlet weak var PokemonCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonUpdate()
        PokemonCollectionView.dataSource = self
        PokemonCollectionView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    func pokemonUpdate(){
        
        NetworkHelper.shared.performDataTask(endpointURLString: "https://api.pokemontcg.io/v1/cards?contains=imageUrl,imageUrlHiRes,attacks") { (error, data, urlResponse) in
            if let response = urlResponse{
                print(response)
            }
            if let appError = error{
                print(appError)
            }
            if let pokemon = data{
                do{
                 let pokemonFound = try JSONDecoder().decode(Cards.self, from: pokemon).cards
                    self.pokemonCard = pokemonFound
                    print(self.pokemonCard.count)
                }
                   catch{
                        print(error)
                    }
                }
            }
        
    }
    

    
}


extension PokemonViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return pokemonCard.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCell", for: indexPath) as? PokemonCell else{return UICollectionViewCell()}
        
        ImageHelper.shared.fetchImage(urlString: pokemonCard[indexPath.row].imageUrlHiRes) { (error, image) in
            if let appError = error{
                print(appError)
            }
            else if let pic = image{
                DispatchQueue.main.async {
                    cell.pokemonImage.image = pic
                    cell.pokemonSpinner.stopAnimating()
                }
                
            }
        }
        
        
        return cell
    }
    
    
}

extension PokemonViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 200, height: 400)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            guard let vc = storyBoard.instantiateViewController(withIdentifier: "PokemonDatails") as? PokemonDetailedViewController else {return}
            
            
            vc.modalPresentationStyle = .overCurrentContext
            vc.pokemonCards = pokemonCard[indexPath.row]
            print(pokemonCard)
            present( vc, animated: true)
    }
    
}
