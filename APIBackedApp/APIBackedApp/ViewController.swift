//
//  ViewController.swift
//  APIBackedApp
//
//  Created by Tim Beals on 2018-09-23.
//  Copyright © 2018 Roobi Creative. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var dataSource = [Person]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

//    var dataSource = ["Name One", "Name Two", "Name Three", "Name Four", "Name Five"]
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(PersonCell.self, forCellReuseIdentifier: PersonCell.reuseIdentifier)
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        view.backgroundColor = UIColor.blue
        
        APIService.fetchData(with: .json) { (data, error) in
            guard error == nil else { print(error!.localizedDescription); return }
            
            if let unwrappedData = data {
                
                self.dataSource = Person.getPeople(from: unwrappedData)
            }
        }
        
        
    }
    
    override func viewWillLayoutSubviews() {
        tableView.removeFromSuperview()
        
        self.tableView.frame = view.frame
        view.addSubview(tableView)
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.personData.count
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PersonCell.reuseIdentifier, for: indexPath) as! PersonCell
        cell.setup(for: self.dataSource[indexPath.row])
//        cell.setup(for: self.personData[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
