//
//  ViewController.swift
//  TestPage
//
//  Created by Admin on 4/2/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, iCarouselDataSource, iCarouselDelegate {
    func numberOfItems(in carousel: iCarousel) -> Int {
         return items.count
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var items: [Int] = []
    @IBOutlet var carousel: iCarousel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for i in 0 ... 99 {
            items.append(i)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carousel.type = .rotary
        
        guard let collectionView = collectionView else { fatalError() }
        collectionView.collectionViewLayout = flowLayout
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    

    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        var itemView: UIView
        
        //reuse view if available, otherwise create a new view
        if let view = view as? UIImageView {
            itemView = view
            //get a reference to the label in the recycled view
            label = itemView.viewWithTag(1) as! UILabel
        } else {
            //don't do anything specific to the index within
            //this `if ... else` statement because the view will be
            //recycled and used with other index values later
            itemView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
            itemView.backgroundColor = .white
            
            
            label = UILabel(frame: itemView.bounds)
            label.backgroundColor = UIColor.clear
            label.textAlignment = .center
            label.font = label.font.withSize(50)
            label.tag = 1
            itemView.addSubview(label)
        }
        
        //set item label
        //remember to always set any properties of your carousel item
        //views outside of the `if (view == nil) {...}` check otherwise
        //you'll get weird issues with carousel item content appearing
        //in the wrong place in the carousel
        label.text = "\(items[index])"
        
        return itemView
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 1.5
        }
        return value
    }
    
    let flowLayout = ZoomAndSnapFlowLayout()
    var currentIndex = -1


}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x/190)
        if currentIndex != index {
            self.currentIndex = index
            print("Scroll: \(index)")
        }
    }
}

class CollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .green
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

