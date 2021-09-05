//
//  FavoriteVC.swift
//  TeamUp
//
//  Created by Apple on 03/09/21.
//

import UIKit

class FavoriteVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tblFavoriteList: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblFavoriteList.register(UINib(nibName: "FavoritesCellTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoritesCellTableViewCell")
        tblFavoriteList.delegate = self
        tblFavoriteList.dataSource = self
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCellTableViewCell") as! FavoritesCellTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    

    

}
