//
//  BRDynamicExpandHeight.swift
//  BRElementPackage
//
//  Created by i9400503 on 2020/1/17.
//  Copyright © 2020 Shine. All rights reserved.
//

import UIKit

class BRDynamicExpandHeight: UIViewController {

    var wordAry : [String] = []

    var words = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeData()
    }
}

extension BRDynamicExpandHeight : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BRDynamicTableViewCell", for: indexPath) as! BRDynamicTableViewCell
        cell.dataAry = wordAry
        cell.collectionView.reloadData()
        cell.collectionView.layoutIfNeeded()
        return cell
    }
}


extension BRDynamicExpandHeight{
    final private func initializeData(){

        wordAry =  (0..<10).map { (_) -> String in
            var letters = ""

            for _ in 0...(Int.random(in: 10...20)){
                let letter =  words[Int.random(in: 0..<words.count)]
                letters.append(letter)
            }

            return letters
        }

    }
}
