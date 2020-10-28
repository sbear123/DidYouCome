//
//  SearchView.swift
//  DidYouCome_Swift
//
//  Created by 박지현 on 2020/10/22.
//

import UIKit
import RxSwift

class SearchView: UIViewController, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate, UITableViewDelegate {
    
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet var LoadingView: UIView!
    let searchController = UISearchController(searchResultsController: nil)
    
    let viewModel: SearchViewModel = SearchViewModel()
    var StudentData = [[String:Any]]()
    var student: UserModel!
    var studentList = [UserModel]()
    var filteredData = [UserModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setView(name: "LoadingView", width: 414, height: 896)
        StudentData = viewModel.GetStudents()
        
        for data in StudentData{
            student = UserModel()
            self.student._name = data["name"] as! String
            self.student._check = data["checkType"] as! String
            self.student._time = data["time"] as! String
            self.studentList.append(student)
        }
        filteredData = studentList
        
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
        TableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.scopeButtonTitles = ["All", "입실", "퇴실"]
        searchController.searchBar.delegate = self
        TableView.delegate = self
        TableView.dataSource = self
        
        LoadingView.removeFromSuperview()
    }
    
    func filterSearchController(_ searchBar: UISearchBar) {
        guard let scopeString = searchBar.scopeButtonTitles?[searchBar.selectedScopeButtonIndex] else { return }
        let selectedElement = UserModel.Element(rawValue: scopeString) ?? .All
        let searchText = searchBar.text!
        
        filteredData = studentList.filter { (user: UserModel) in
            let isElementMatching = (selectedElement == .All) || (user._check == selectedElement.rawValue)
            let isMatchingSearchText = user._name.lowercased().contains(searchText.lowercased())
            return isElementMatching && isMatchingSearchText
        }
        
        TableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchTableViewCell
        let students = searchController.isActive && searchController.searchBar.text != "" ? filteredData[indexPath.row] : studentList[indexPath.row]
        
        
        cell.name.text = students._name
        cell.check.text = students._check
        cell.time.text = students._time
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.isActive && searchController.searchBar.text != ""  ? filteredData.count : studentList.count
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterSearchController(searchController.searchBar)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterSearchController(searchBar)
    }
    
    func setView(name: String, width:Int, height: Int) -> Void {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller: UIViewController = storyboard.instantiateViewController(withIdentifier: name) as UIViewController
        addChild(controller)
        LoadingView.addSubview(controller.view)
        controller.view.frame = view.bounds
        controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        // tell the childviewcontroller it's contained in it's parent
        controller.didMove(toParent: self)
        controller.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }
}
