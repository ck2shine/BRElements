//
//  ResultFooter.swift
//  BRElementPackage
//
//  Created by Shine on 2020/1/4.
//  Copyright © 2020 Shine. All rights reserved.
//

import UIKit
class ResultFooter : UIView{
    
    @IBOutlet weak var heightConstraint : NSLayoutConstraint!
    
    let resultLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    public var showFooter : Bool = false {
        didSet{
            if showFooter{
                UIView.animate(withDuration: 0.7) {
                    self.alpha = 1.0
                    //self.heightConstraint.constant = 50
                    self.layoutIfNeeded()
                }
            }else{
                UIView.animate(withDuration: 0.7) {
                    self.alpha = 0.0
                    //self.heightConstraint.constant = 0
                    self.layoutIfNeeded()
                }
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        resultLabel.frame = bounds
    }
}

extension ResultFooter{
    
    final public func setFilterResult(filteredItemCount: Int, of totalItemCount: Int) {
      if (filteredItemCount == totalItemCount) {
        notFiltering()
      } else if (filteredItemCount == 0) {
        resultLabel.text = "No result for searching"
        showFooter = false
      } else {
        resultLabel.text = "Filtering \(filteredItemCount) of \(totalItemCount)"
        showFooter = true
      }
    }
    
    final public func notFiltering(){
        resultLabel.text = ""
        showFooter = false
    }
    
    final private func configureView(){
        backgroundColor = .gray
        alpha = 0.0 //default is hiding
        resultLabel.textAlignment = .center
        resultLabel.textColor = .white
        addSubview(resultLabel)
    }
}
