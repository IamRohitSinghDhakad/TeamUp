//
//  SearchResultVC.swift
//  TeamUp
//
//  Created by Apple on 03/09/21.
//

import UIKit

class SearchResultVC: UIViewController,UITableViewDelegate,UITableViewDataSource,myViewDelegate {
    
    

    @IBOutlet weak var tblSearchList: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search Result"
        tblSearchList.register(UINib(nibName: "FavoritesCellTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoritesCellTableViewCell")
        tblSearchList.delegate = self
        tblSearchList.dataSource = self
        
        let filterButton = UIBarButtonItem(image: UIImage(named: "filter"), style: .plain, target: self, action: #selector(filter))
            self.navigationItem.rightBarButtonItem  = filterButton
        
        

    }
    
    @objc func filter(){
        let vc = storyboard?.instantiateViewController(identifier: "FilterVC") as! FilterVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCellTableViewCell") as! FavoritesCellTableViewCell
        cell.hgtConstantHart.constant = 0
        cell.delegate = self
        return cell
    }
    

    @IBAction func btnSave(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "LocationVC") as! LocationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func callViewProfile(index: Int) {
        let vc = storyboard?.instantiateViewController(identifier: "ViewProfileVC") as! ViewProfileVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
