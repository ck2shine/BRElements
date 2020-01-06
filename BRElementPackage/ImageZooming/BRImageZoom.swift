//
//  BRImageZoom.swift
//  BRElementPackage
//
//  Created by Shine on 2019/12/8.
//  Copyright © 2019 Shine. All rights reserved.
//

import UIKit

class BRImageZoom: UIViewController {
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewBottonConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var ZoomImageView: UIImageView!
    @IBOutlet weak var ImageScrollView: UIScrollView!
    
    var photoName : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.ZoomImageView.image =   changeImageViewSize()


        
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

    func changeImageViewSize() ->UIImage?{
        guard let photoName = photoName else {return nil}
        let image = UIImage(named: photoName)

        if  Int(image?.size.width ?? 0) > Int(image?.size.height ?? 0){

            imageHeightConstraint.constant = 768
            imageWidthConstraint.constant = 1024
            view.layoutIfNeeded()
            return image?.resizeImage(CGSize(width: 1024, height: 768))
        }else{
            imageHeightConstraint.constant = 1024
            imageWidthConstraint.constant = 768
            view.layoutIfNeeded()
            return image?.resizeImage(CGSize(width: 768, height: 1024))

        }

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
        print(ZoomImageView.frame)
        let yOffset = max(0, (size.height - ZoomImageView.frame.height) / 2)
        imageViewTopConstraint.constant = yOffset
        imageViewBottonConstraint.constant = yOffset

        let xOffset = max(0, (size.width - ZoomImageView.frame.width) / 2)
        imageViewLeadingConstraint.constant = xOffset
        imageViewTrailingConstraint.constant = xOffset
        
        view.layoutIfNeeded()
    }
}


extension UIImage{
    func resizeImage(_ size : CGSize) -> UIImage{
        let render = UIGraphicsImageRenderer(size: size)
        let reSizeImage = render.image { _ in
            draw(in: CGRect(origin: CGPoint.zero, size: size))
        }
        return reSizeImage
    }
}
