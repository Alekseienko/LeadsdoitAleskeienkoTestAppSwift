//
//  ViewController.swift
//  LeadsdoitAleskeienkoTestAppSwift
//
//  Created by alekseienko on 23.06.2022.
//

import UIKit
import AlignedCollectionViewFlowLayout

class MenuVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    // Общий фон меню
    @IBOutlet weak var backgroundView: UIView!
    // Колличество очков игрока
    @IBOutlet weak var scoreView: UIView!
    @IBOutlet weak var userScore: UILabel!
    @IBOutlet weak var gameLogo: UIImageView!
    // Переключатель "piker" между популярными и всеми играми
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    // Колекция ыв которой будут картинки
    @IBOutlet weak var collectionView: UICollectionView!
    // Три игры с разными картинками
    
    
    
    
    
    var slotGames = [
        SlotModel(name: "slot1",
                isPopular: true,
                backgroungImage: "SP1_background",
                slotImageArray: ["SP1_0", "SP1_1", "SP1_2", "SP1_3", "SP1_4", "SP1_5", "SP1_6", "SP1_7", "SP1_8"],
                logoImage: "SP1_8",
                countLines: 5),
        SlotModel(name: "slot2",
                  isPopular: false,
                  backgroungImage: "SP2_background",
                  slotImageArray: ["SP2_0", "SP2_1", "SP2_2", "SP2_3", "SP2_4", "SP2_5", "SP2_6", "SP2_7", "SP2_8"],
                  logoImage: "SP2_8",
                  countLines: 5),
        SlotModel(name: "slot3",
                  isPopular: false,
                  backgroungImage: "SP3_background",
                  slotImageArray: ["SP3_0", "SP3_1", "SP3_2", "SP3_3", "SP3_4", "SP3_5", "SP3_6", "SP3_7", "SP3_8"],
                  logoImage: "SP3_8",
                  countLines: 5)
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        segmentedControl.addUnderlineForSelectedSegment()
        self.backgroundView.layer.cornerRadius = 60

        let flowLayout = collectionView?.collectionViewLayout as? AlignedCollectionViewFlowLayout
        flowLayout?.horizontalAlignment = .left
        flowLayout?.minimumLineSpacing = 20
        flowLayout?.minimumInteritemSpacing = 16
        userScore.text = String(UserScore().getScore())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        userScore.text = String(UserScore().getScore())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
    }
    override var shouldAutorotate: Bool {
        return false
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    

    @IBAction func segmentedControlPressed(_ sender: Any) {
        segmentedControl.changeUnderlinePosition()
        collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0 :  return 1
        case 1 :  return slotGames.count
        default: return 0
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let gameCell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as? MenuCollectionViewCell {
            gameCell.menu = slotGames[indexPath.row]
            return gameCell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "GameVC") as! GameVC
       // vc.currentBank = score
        vc.currentGame = slotGames[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}




