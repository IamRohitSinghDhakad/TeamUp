//
//  NotificationVC.swift
//  TeamUp
//
//  Created by Apple on 04/09/21.
//

import UIKit

class NotificationVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tblNotification: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblNotification.register(UINib(nibName: "NotificationCell", bundle: nil), forCellReuseIdentifier: "NotificationCell")
        tblNotification.delegate = self
        tblNotification.dataSource = self
        
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell") as! NotificationCell
        return cell
    }
    

    

}
