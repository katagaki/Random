//
//  DoDrawCardsViewController.swift
//  Random
//
//  Created by 堅書真太郎 on 2021/06/10.
//

import UIKit

class DoDrawCardsViewController: UIViewController, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 52
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: IndexPath(row: 0, section: 0))
    }
    
    
}
