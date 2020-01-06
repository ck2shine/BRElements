//
//  BRPageManagerViewController.swift
//  BRElementPackage
//
//  Created by i9400503 on 2020/1/6.
//  Copyright © 2020 Shine. All rights reserved.
//

import UIKit

class BRPageManagerViewController: UIPageViewController {

    var photoAry : [String]?

    var currentIdx : Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self

        let viewController = self.generateSinglePage(currentIdx)
        let viewControllers = [viewController]
        setViewControllers(viewControllers, direction: .forward, animated: false, completion: nil)
    }

    func generateSinglePage(_ index : Int)->BRPhotoPagesViewController{
         let vc = storyboard?.instantiateViewController(withIdentifier: "BRPhotoPagesViewController") as? BRPhotoPagesViewController
        vc?.photoName = photoAry![index]
        vc?.index = index
        return vc!
    }
}

extension BRPageManagerViewController : UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewController = viewController as? BRPhotoPagesViewController , let index = viewController.index , index > 0{
            return generateSinglePage(index - 1)
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewController = viewController as? BRPhotoPagesViewController , let index = viewController.index , index + 1 < photoAry!.count{
            return generateSinglePage(index + 1)
        }
        return nil
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return photoAry?.count ?? 0
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIdx ?? 0 
    }

}
