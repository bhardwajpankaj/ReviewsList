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
        
        tableView.prefetchDataSource = self
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        
        // Change font size for bar Button
        lefrBarButtonItem.setTitleTextAttributes([kCTFontAttributeName as NSAttributedString.Key: UIFont.systemFont(ofSize: 22, weight: .bold)], for: .normal)
        // Register custom cell to the tableview
        tableView.register(cell: ReviewTableViewCell.self)
    }
    
    func didTapRetryButtonCalled() {
        fetchData()
    }
    // Asking Data from view Model
    @objc func fetchData(){
        
        if Reachability.isConnectedToNetwork(){
            viewModel?.getUserInfoFromStarting(completionHandler: {[weak self] (message) in
                if message != nil{
                    //Handle Message
                }else {
                    self?.tableView.reloadData()
                }
                self?.activityIndicator.stopAnimating()
            })
            
        }else{
            let noNetworkController = NoNetworkViewController(nibName: "NoNetworkViewController", bundle: nil)
            self.present(noNetworkController , animated: true)
            print("Internet Connection not Available!")
        }
    }
}

// Tableview data source
extension ReviewListController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.reviewModel?.totalReviewsComments) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isLoadingIndexPath(indexPath) {
            return LoadingCell(style: .default, reuseIdentifier: "loading")
        } else {
            
        let cell : ReviewTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        if let review = viewModel?.arrReviews?[indexPath.item]{
            cell.updateInterface(review: review)
        }
        return cell
        }
    }
    private func isLoadingIndexPath(_ indexPath: IndexPath) -> Bool {
        return indexPath.row >= self.viewModel?.arrReviews?.count ?? 0
    }
}

// MARK: - UITableViewDataSourcePrefetching
extension ReviewListController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let needsFetch = indexPaths.contains { $0.row >= self.viewModel?.arrReviews?.count ?? 0 }
        if needsFetch {
            self.viewModel?.getNextUserInfo(completionHandler: { (message) in
                if message != nil {
                    //Handle Message
                }else {

                }
            })
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
    }
}

