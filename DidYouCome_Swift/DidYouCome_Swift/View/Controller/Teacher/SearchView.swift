//
//  SearchView.swift
//  DidYouCome_Swift
//
//  Created by 박지현 on 2020/10/22.
//

import UIKit
import RxSwift

class SearchView: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var LoadingView: UIView!
    
    let viewModel: SearchViewModel = SearchViewModel()
    var StudentData = [[String:Any]]()
    var student: UserModel!
    var studentList = [UserModel]()
    var filteredArray = [UserModel]()
    
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
        filteredArray = studentList
        
        TableView.delegate = self
        TableView.dataSource = self
        searchBar.delegate = self
        
        LoadingView.removeFromSuperview()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchTableViewCell
        let students = studentList[indexPath.row]
        
        cell.name.text = students._name
        cell.check.text = students._check
        cell.time.text = students._time
        
        return cell
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
