//
//  BRImageZoom.swift
//  BRElementPackage
//
//  Created by Shine on 2019/12/8.
//  Copyright © 2019 Shine. All rights reserved.
//

import UIKit

class BRImageZoom: UIViewController {
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewBottonConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var ZoomImageView: UIImageView!
    @IBOutlet weak var ImageScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        self.ZoomImageView.image = UIImage(named: "Snowboard.JPG")
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateImageZoomSize(view.bounds.size)
    }
    
    func updateImageZoomSize(_ size : CGSize){
        //choose the min value to fit the screen
        let width = size.width / ZoomImageView.bounds.width
        let height = size.height / ZoomImageView.bounds.height
        let minScale = min(width, height)
        ImageScrollView.minimumZoomScale = minScale
        ImageScrollView.zoomScale = minScale
    }
}

extension BRImageZoom : UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return ZoomImageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateConstraintsForSize(view.bounds.size)
    }
    
 
    //keep the image in the center
    func updateConstraintsForSize(_ size: CGSize) {
      
      let yOffset = max(0, (size.height - ZoomImageView.frame.height) / 2)
      imageViewTopConstraint.constant = yOffset
      imageViewBottonConstraint.constant = yOffset
     
      let xOffset = max(0, (size.width - ZoomImageView.frame.width) / 2)
      imageViewLeadingConstraint.constant = xOffset
      imageViewTrailingConstraint.constant = xOffset
        
      view.layoutIfNeeded()
    }
}
