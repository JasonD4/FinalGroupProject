//
//  ViewController.swift
//  TeamWork (Jason & Olimpia)
//
//  Created by Olimpia on 1/9/19.
//  Copyright © 2019 Olimpia. All rights reserved.
//

import UIKit

class MagicViewController: UIViewController {

    private var magicCard = [MagicCards](){
        didSet {
            DispatchQueue.main.async {
                self.MagicCollectionView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var MagicCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        MagicCollectionView.dataSource = self
        MagicCollectionView.delegate = self
    giveUsTheData()
       
        
        
        
        
    }
    
    
    func giveUsTheData() {
        NetworkHelper.shared.performDataTask(endpointURLString:  "https://api.magicthegathering.io/v1/cards?contains=imageUrl") { (error, data, urlResponse) in
            if let error = error {
                print(AppError.errorMessage(error))
            }
            if let data = data {
                do{
                    let card = try JSONDecoder().decode(CardsForMagic.self, from: data).cards.filter() {$0.imageUrl != nil}
                    self.magicCard = card
                    print(self.magicCard.count)
                }
                catch{
                    print(error)
                }
            }
        }
    }


}

extension MagicViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return magicCard.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = MagicCollectionView.dequeueReusableCell(withReuseIdentifier: "MagicCell", for: indexPath) as? MagicCell else { return UICollectionViewCell() }
        ImageHelper.shared.fetchImage(urlString: magicCard[indexPath.row].imageUrl!) { (error, image) in
            if let error = error {
                print(AppError.errorMessage(error))
            } else if let image = image {
                cell.magicImage.image = image
                cell.magicSpinerThingy.stopAnimating()
            }
        }
        return cell
    }
    
    
}

extension MagicViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 200, height: 300)
    }
}


extension MagicViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "DetailedView") as? MagicDetailedViewController else { return }
      vc.modalPresentationStyle = .overCurrentContext
        vc.currentCard = magicCard[indexPath.row]
        present(vc, animated: true, completion: nil)
 
    

    }
}
