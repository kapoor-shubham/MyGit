//
//  ViewController.swift
//  MyGit
//
//  Created by Shubham Kapoor on 29/01/19.
//  Copyright © 2019 Shubham Kapoor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var gitModelObj: [GitModelElement]?
    var pageNumber = 1
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData(page: pageNumber)
    }

    func getData(page: Int) {
        APIRequestManager.apiRequestManager.apiCall(url: gitURL(page: page), httpType: .RequestTypeGet, header: nil, params: nil, modelType: GitModel.self) { (response, success, error) in
            guard error == nil else {
                print(error ?? APIError.unknownError)
                return
            }
            
            if success == true && response != nil {
                self.gitModelObj = response as? [GitModelElement]
                DispatchQueue.main.async {
                    self.headerLabel.text = (self.gitModelObj?[0].owner.login).map { $0.rawValue }
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (gitModelObj?.count)!-3 {
            pageNumber = pageNumber+1
            getData(page: pageNumber)
        }
    }
}
