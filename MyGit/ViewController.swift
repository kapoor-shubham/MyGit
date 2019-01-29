//
//  ViewController.swift
//  MyGit
//
//  Created by Shubham Kapoor on 29/01/19.
//  Copyright © 2019 Shubham Kapoor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var gitModelObj: GitModel?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }

    func getData() {
        APIRequestManager.apiRequestManager.apiCall(url: baseURL!, httpType: .RequestTypeGet, header: nil, params: nil, modelType: GitModel.self) { (response, success, error) in
            guard error == nil else {
                print(error ?? APIError.unknownError)
                return
            }
            
            if success == true && response != nil {
                self.gitModelObj = response as? GitModel
                DispatchQueue.main.async {
                    self.tableView.dataSource = self
                    self.tableView.delegate = self
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (gitModelObj?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GitTableViewCell", for: indexPath) as! GitTableViewCell
        cell.titleLabel?.text = gitModelObj?[indexPath.row].name
        cell.descriptionLabel?.text = gitModelObj?[indexPath.row].description
        cell.languageNameLabel?.text = gitModelObj?[indexPath.row].language ?? "-"
        cell.watchersCountLabel?.text = "\(gitModelObj?[indexPath.row].watchersCount ?? 0)"
        cell.forksCountLabel?.text = "\(gitModelObj?[indexPath.row].forksCount ?? 0)"
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 126
    }
}
