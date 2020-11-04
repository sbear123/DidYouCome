//
//  TeacherHomeView.swift
//  DidYouCome_Swift
//
//  Created by 박지현 on 2020/10/22.
//

import UIKit
import RxSwift

class TeacherHomeView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let userData: UserViewModel = UserViewModel()
    let viewModel: StudentTableViewModel = StudentTableViewModel()
    var StudentData = [[String:Any]]()
    var studentName = [String]()
    var studentCheck = [String]()
    var studentTime = [String]()
    
    @IBOutlet weak var LoadingView: UIView!
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var Check: UILabel!
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
                                    #selector(handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Check.text = userData.GetUser("check") + "확인"
        setView(name: "LoadingView", width: 414, height: 896)
        setTable()
        TableView.addSubview(self.refreshControl)
        
        LoadingView.removeFromSuperview()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath) as! StudentTableViewCell
        
        cell.name.text = studentName[indexPath.row]
        cell.check.text = studentCheck[indexPath.row]
        cell.time.text = studentTime[indexPath.row]
        
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
    
    func setTable() {
        StudentData = viewModel.GetStudents()
        
        for student in StudentData{
            self.studentName.append(student["name"] as! String)
            self.studentCheck.append(student["checkType"] as! String)
            self.studentTime.append(student["time"] as! String)
        }
        
        self.TableView.delegate = self
        self.TableView.dataSource = self
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        setTable()
        refreshControl.endRefreshing()
    }
}


