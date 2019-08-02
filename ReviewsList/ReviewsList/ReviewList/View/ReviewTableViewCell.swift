//
//  ReviewTableViewCell.swift
//  ReviewsList
//
//  Created by Pankaj Bhardwaj on 02/08/19.
//  Copyright © 2019 Pankaj Bhardwaj. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell, ReuseIdentifier ,NibLoadableView{
        
        @IBOutlet weak var author: UILabel!
        @IBOutlet weak var titleLbl: UILabel!
        @IBOutlet weak var messageLbl: UILabel!
        @IBOutlet weak var dateLbl: UILabel!
        @IBOutlet weak var ratingView: RatingView!
        @IBOutlet weak var authorLogoLbl: UILabel!
        @IBOutlet weak var authorLogoBgView: UIView!
        
        var sessionTask : URLSessionTask?
        override func prepareForReuse() {
            super.prepareForReuse()
        }
        
        func updateInterface(review:Review){
            
            if let titleLblText = review.title,titleLblText.count > 0{
                titleLbl.text = "\"\(titleLblText)\""
            }else
            {
                titleLbl.text = ""
            }
            author.text = "\(review.author ?? "")"
            messageLbl.text = "\(review.message ?? "")"
            dateLbl.text = self.getConvertedDate(dateText: review.date ?? "")
            if let firstChar = review.reviewerName?.prefix(1){
                authorLogoLbl.text = "\(firstChar)"
            }
            ratingView.rating = ((review.rating ?? "") as NSString).floatValue
            authorLogoBgView.backgroundColor = UIColor.random
        }
        
        func getConvertedDate(dateText:String) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM dd, yyyy" //this your string date format
            let convertedDate = dateFormatter.date(from: dateText)
            
            guard dateFormatter.date(from: dateText) != nil else {
                return ""
            }
            
            dateFormatter.dateFormat = "dd MMMM yyyy" //this is what you want to convert format
            let timeStamp = dateFormatter.string(from: convertedDate!)
            return timeStamp
        }
}
