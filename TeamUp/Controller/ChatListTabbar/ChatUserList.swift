//
//  ChatUserList.swift
//  TeamUp
//
//  Created by Apple on 05/09/21.
//

import UIKit

class ChatUserList: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tblUserChatList: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblUserChatList.delegate = self
        self.tblUserChatList.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserChatCell") as! UserChatCell
        cell.lblMessage.text! = "How are you..."
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "ChatListVC") as! ChatListVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

   

}

class UserChatCell:UITableViewCell {
    
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblMessage: UILabel!
}
