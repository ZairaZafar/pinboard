//
//  ViewController.swift
//  ResourceDownloadManager
//
//  Created by Zaira Zafar on 25/05/2019.
//  Copyright © 2019 Zaira Zafar. All rights reserved.
//

import UIKit

class PinboardViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let transition = PopAnimator()
    
    var selectedImage: UIImageView?
    var selectedIndex: IndexPath!
    var requestPhotos: PhotosRequest!
    var dataSource: DataManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = DataManager()
        dataSource.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        navigationItem.title = "Pinboard"
        
        transition.dismissCompletion = {
            self.selectedImage!.isHidden = false
        }
        
        requestPhotos = PhotosRequest(baseUrl: "", url: "http://pastebin.com/raw/wgkJgazE", parameters: [:], method: .get)
        
        dataSource.request(photos: requestPhotos)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension PinboardViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PinboardCollectionViewCell.self), for: indexPath) as! PinboardCollectionViewCell
        cell.pinboardImage.image = dataSource.images[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PinboardCollectionViewCell.self), for: indexPath) as! PinboardCollectionViewCell
        selectedImage = cell.pinboardImage
        selectedIndex = indexPath
        let imageDetails = storyboard!.instantiateViewController(withIdentifier: String(describing: ImageDetailsViewController.self)) as! ImageDetailsViewController
        
        imageDetails.user = dataSource.user[indexPath.row]
        imageDetails.like = dataSource.likes[indexPath.row]
        imageDetails.image = dataSource.images[indexPath.row]
        imageDetails.category = dataSource.categories[indexPath.row]
        imageDetails.transitioningDelegate = self
        
        present(imageDetails, animated: true, completion: nil)
    }
    
    
    //Paginataion Example
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        // check if scroll has reached end of view
        if contentOffsetY >= scrollView.contentSize.height - scrollView.bounds.height + 50 {
            //reform your url and request data
            requestPhotos.url = "http://pastebin.com/raw/wgkJgazE"
            dataSource.request(photos: requestPhotos)
        }
    }
    
}

extension PinboardViewController: ViewProtocols {
    
    func viewReload() {
        collectionView.reloadData()
    }
    
}


extension PinboardViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let selectedCell = collectionView.cellForItem(at: selectedIndex)
        transition.originFrame = selectedCell!.convert(selectedImage!.frame, to: nil)
        
        transition.presenting = true
        selectedImage!.isHidden = true
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
}
