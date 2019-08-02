//
//  ReviewListController.swift
//  ReviewsList
//
//  Created by Pankaj Bhardwaj on 02/08/19.
//  Copyright © 2019 Pankaj Bhardwaj. All rights reserved.
//

import UIKit

class ReviewListController: UIViewController,NoNetworkViewControllerDelegate {
    
    var viewModel: ReviewsViewModel?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private var refreshControl:UIRefreshControl!
    @IBOutlet weak var lefrBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        viewModel = ReviewsViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
        fetchData()
    }
    
    private func setupUI() {
        
        self.tableView?.rowHeight = UITableView.automaticDimension
        self.tableView?.estimatedRowHeight = 200
        self.refreshControl = UIRefreshControl()
        
        // refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        // Change font size for bar Button
        lefrBarButtonItem.setTitleTextAttributes([kCTFontAttributeName as NSAttributedString.Key: UIFont.systemFont(ofSize: 22, weight: .bold)], for: .normal)
        // Register custom cell to the tableview
        self.tableView?.register(cell: ReviewTableViewCell.self)
    }
    
    func didTapRetryButtonCalled() {
        fetchData()
    }
    // Asking Data from view Model
    @objc func fetchData(){
        
        if Reachability.isConnectedToNetwork(){
            viewModel?.getUserInfoFromStarting(completionHandler: { (message) in
                if message != nil{
                    //Handle Message
                }else {
                    self.tableView?.reloadData()
                }
                self.refreshControl.endRefreshing()
                self.activityIndicator.stopAnimating()
            })
            
        }else{
            let noNetworkController = NoNetworkViewController(nibName: "NoNetworkViewController", bundle: nil)
            self.present(noNetworkController , animated: true)
            print("Internet Connection not Available!")
        }
    }
}

// Tableview dalegates method
extension ReviewListController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if let count = viewModel?.arrReviews?.count {
            if indexPath.row == count - 1 && viewModel?.boolLoading == false && viewModel?.boolMoreDataAvailable == true {
                self.viewModel?.getNextUserInfo(completionHandler: { (message) in
                    if message != nil {
                        //Handle Message
                    }else {
                        self.tableView?.reloadData()
                    }
                })
            }
        }
    }
}
// Tableview data source
extension ReviewListController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.arrReviews?.count) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : ReviewTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        if let review = viewModel?.arrReviews?[indexPath.item]{
            cell.updateInterface(review: review)
        }
        return cell
    }
}
