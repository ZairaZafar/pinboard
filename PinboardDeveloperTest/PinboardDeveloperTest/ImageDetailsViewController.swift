//
//  ImageDetailsViewController.swift
//  ResourceDownloadManager
//
//  Created by Zaira Zafar on 28/05/2019.
//  Copyright © 2019 Zaira Zafar. All rights reserved.
//

import UIKit

class ImageDetailsViewController: UIViewController, UIViewControllerTransitioningDelegate{

    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var like: Int!
    var user: String!
    var image: UIImage!
    var category: String!
    
//    var index: Int!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        backgroundImage.image = image
        categoryLabel.text = category
        userLabel.text = "By user " + user
        likesLabel.text = "Liked by \(String(like)) people"
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionClose(_:))))
    }
    
    @objc func actionClose(_ tap: UITapGestureRecognizer) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
