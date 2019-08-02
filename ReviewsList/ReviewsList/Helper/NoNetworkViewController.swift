//
//  NoNetworkViewController.swift
//  ReviewsList
//
//  Created by Pankaj Bhardwaj on 02/08/19.
//  Copyright © 2019 Pankaj Bhardwaj. All rights reserved.
//

import UIKit
protocol NoNetworkViewControllerDelegate {
    func didTapRetryButtonCalled()
}
class NoNetworkViewController: UIViewController {

    @IBOutlet weak var retryBtn:UIButton!
    @IBOutlet weak var imageView:UIImageView!
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var descLabel:UILabel!
    var delegate:NoNetworkViewControllerDelegate?
    var isNetworkError = true
    
    class func instance()->NoNetworkViewController{
        let noNetworkViewController = NoNetworkViewController.init(nibName: "NoNetworkViewController", bundle: nil)
        return noNetworkViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retryBtn.layer.cornerRadius = retryBtn.bounds.height/2
        retryBtn.layer.masksToBounds = true
        retryBtn.layer.borderWidth = 1.0
        retryBtn.layer.borderColor = UIColor.blue.cgColor
        
        if(!isNetworkError){
            retryBtn.isHidden = true
            imageView.image = UIImage(named: "rocketStanding")
            titleLabel.text = "Oops!"
            descLabel.text = "We are currently in a limited beta release and are catering to a limited set of users. We shall get back to you soon."
        }
    }
    
    @IBAction func didTapRetryButton(_ sender:UIButton){
        self.dismiss(animated: true, completion: nil)
        self.delegate?.didTapRetryButtonCalled()
    }
}
