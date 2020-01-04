//
//  MainListController.swift
//  BRElementPackage
//
//  Created by Shine on 2020/1/2.
//  Copyright © 2020 Shine. All rights reserved.
//

import Foundation
import UIKit
class MainListController :UIViewController{
    @IBOutlet weak var SearchHeaderView: ResultFooter!
    
    @IBOutlet weak var resultFooterConstraint: NSLayoutConstraint!
    @IBOutlet weak var dataTable: UITableView!
    var depts : [Department] = []
    var filterDepts  : [Department] = []
    let seachrViewController = UISearchController(searchResultsController: nil)
    
    var isFiltering : Bool{
        let searchBarScopeIsFiltering = seachrViewController.searchBar.selectedScopeButtonIndex != 0
        //is active that means user is filtering data with searchBarText or filter scope
        return seachrViewController.isActive && (!isSearchEmpty || searchBarScopeIsFiltering)
    }
    
    var isSearchEmpty : Bool{
        return seachrViewController.searchBar.text?.isEmpty ?? true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        depts = Department.loadDepts()
        seachrViewController.searchResultsUpdater = self
        seachrViewController.searchBar.placeholder = "Seach for Dept"
        seachrViewController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = seachrViewController
        definesPresentationContext = true
        seachrViewController.searchBar.scopeButtonTitles = Department.BelowDept.allCases.map({$0.rawValue
        })
        seachrViewController.searchBar.delegate = self
        //SearchHeaderView.heightConstraint.constant = 0
       
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification, object: nil, queue: .main) { (notification) in
            self.handlerKeyBoard(notification: notification)
        }
        notificationCenter.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (notification) in
            self.handlerKeyBoard(notification: notification)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let index = dataTable.indexPathForSelectedRow{
            dataTable.deselectRow(at: index, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" ,let index = dataTable.indexPathForSelectedRow?.row ,  let detailVC = segue.destination as? DetailViewController{
            if isFiltering{
                detailVC.deptData = filterDepts[index ]
            }else{
                detailVC.deptData = depts[index ]
            }
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        NotificationCenter.default.removeObserver(self)
        
        super.viewWillDisappear(animated)
    }
}


extension MainListController : UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering{
            SearchHeaderView.setFilterResult(filteredItemCount: filterDepts.count, of: depts.count)
            return filterDepts.count
        }
        SearchHeaderView.notFiltering()
        return depts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell" , for : indexPath)
        let dept : Department
        if isFiltering{
            dept = filterDepts[indexPath.row]
        }else{
            dept = depts[indexPath.row]
        }
        
        
        cell.textLabel?.text = dept.BranchName
        cell.detailTextLabel?.text = dept.Dep?.rawValue
        
        return cell
    }
    
    
}

extension MainListController : UISearchResultsUpdating , UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let dept = Department.BelowDept(rawValue: searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex])
        filterContentForSearch(searchBar.text! , dept: dept)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        let belowDept = Department.BelowDept(rawValue:searchBar.scopeButtonTitles![selectedScope])
        filterContentForSearch(searchBar.text!, dept: belowDept)
    }
    
}

extension MainListController{
    final private func filterContentForSearch(_ filterStr : String , dept : Department.BelowDept? = nil){
        
        
        filterDepts = depts.filter({
            let matchDept = dept == .all || $0.Dep == dept!
            if isSearchEmpty{//use scope
                return matchDept
            }else{
                return matchDept && $0.BranchName?.lowercased().contains(filterStr.lowercased()) ?? false
            }
        })
        self.dataTable.reloadData()
    }
    
    final private func handlerKeyBoard(notification : Notification){
        guard notification.name == UIResponder.keyboardWillChangeFrameNotification else {
            self.resultFooterConstraint.constant = 0
            //self.SearchHeaderView.heightConstraint.constant = 50
            view.layoutIfNeeded()
            return
        }
        guard let info = notification.userInfo , let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return }
        let keyboardHeight = keyboardFrame.cgRectValue.size.height
        UIView.animate(withDuration: 0.1) {
            self.resultFooterConstraint.constant = keyboardHeight
            //self.SearchHeaderView.heightConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }
}
