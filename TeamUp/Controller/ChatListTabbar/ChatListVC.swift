//
//  ChatListVC.swift
//  TeamUp
//
//  Created by Apple on 03/09/21.
//

import UIKit

class ChatListVC: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tblChatList: UITableView!
    @IBOutlet var txtVwChat: RDTextView!
    @IBOutlet var hgtConsMaximum: NSLayoutConstraint!
    @IBOutlet var hgtConsMinimum: NSLayoutConstraint!
    
    let txtViewCommentMaxHeight: CGFloat = 100
    let txtViewCommentMinHeight: CGFloat = 34
    
  //  var arrChatMsg = NSMutableArray()
    var arrChatMsg = [ChatDetailModel]()
    var dictPrevious = NSDictionary()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("dictPrevious>>>>>\(dictPrevious)")
        tblChatList.delegate = self
        tblChatList.dataSource = self
        self.title = "Chat"
        self.txtVwChat.delegate = self
        
        self.call_GetChat()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrChatMsg.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatListCell") as! ChatListCell
        
        
        let obj = self.arrChatMsg[indexPath.row]
        
//        if obj.strImageUrl != ""{
//            if obj.strSenderId == objAppShareData.UserDetail.strUserId{
//                cell.vwMyMsg.isHidden = true
//                cell.vwOpponent.isHidden = true
//                cell.vwOpponentImage.isHidden = true
//                cell.vwMyImage.isHidden = false
//
//                if obj.strType == "Sticker" || obj.strType == "sticker"{
//                    cell.vwContainImgBorderMySide.backgroundColor = .clear
//                    cell.imgVwMySide.contentMode = .scaleAspectFit
////                    cell.vwContainImgBorderMySide.isHidden = false
////                    cell.imgVwMySide.contentMode = .scaleAspectFill
//                }else{
//                    cell.vwContainImgBorderMySide.backgroundColor = UIColor.init(named: "AppSkyBlue")
//                    cell.imgVwMySide.contentMode = .scaleAspectFill
//                }
//
//                let profilePic = obj.strImageUrl
////                if profilePic != "" {
////                    let url = URL(string: profilePic)
////                    cell.imgVwopponent.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "splashLogo"), options: .refreshCached) { (image, error, cacheType, url) in
////                        if image != nil {
////                            cell.imgVwopponent.image = image
////                        }
////                        if let error = error {
////                            print("URL: \(url), error: \(error)")
////                        }
////                    }
//////                    cell.imgVwMySide.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "logo_square"))
////                }
//
//                cell.imgVwMySide.imageFromServerURL(urlString: profilePic, PlaceHolderImage: #imageLiteral(resourceName: "logo_square"))
//
//
//
//            }else{
//                cell.vwMyMsg.isHidden = true
//                cell.vwOpponent.isHidden = true
//                cell.vwOpponentImage.isHidden = false
//                cell.vwMyImage.isHidden = true
//
//
//                if obj.strType == "Sticker" || obj.strType == "sticker"{
//                    cell.vwContainImgBorderOpponentSide.backgroundColor = .clear
//                    cell.imgVwopponent.contentMode = .scaleAspectFit
////                    cell.vwContainImgBorderOpponentSide.isHidden = false
////                    cell.imgVwopponent.contentMode = .scaleAspectFill
//                }else{
//                    cell.vwContainImgBorderOpponentSide.backgroundColor = UIColor.init(named: "AppSkyBlue")
//                    cell.imgVwopponent.contentMode = .scaleAspectFill
//                }
//
//                let profilePic = obj.strImageUrl
//                cell.imgVwopponent.imageFromServerURL(urlString: profilePic, PlaceHolderImage: #imageLiteral(resourceName: "logo_square"))
//            }
//        }else{
        if obj.strSenderId == "1"{//objAppShareData.UserDetail.strUserId{
                cell.vwMyMsg.isHidden = false
                cell.lblMyMsg.text = obj.strOpponentChatMessage
                cell.lblMyMsgTime.text = obj.strOpponentChatTime
                cell.vwOpponent.isHidden = true
            }else{
                cell.lblOpponentMsg.text = obj.strOpponentChatMessage
                cell.lblopponentMsgTime.text = obj.strOpponentChatTime
                cell.vwOpponent.isHidden = false
                cell.vwMyMsg.isHidden = true
            }
    //    }
        
        cell.lblOpponentMsg.text = obj.strOpponentChatMessage
        cell.lblopponentMsgTime.text = obj.strChatTime
        cell.lblMyMsgTime.text = obj.strChatTime
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "SheduleRequestVC") as! SheduleRequestVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnSendMessage(_ sender: Any) {
        if (txtVwChat.text?.isEmpty)!{
            
            self.txtVwChat.text = "."
            self.txtVwChat.text = self.txtVwChat.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            self.txtVwChat.isScrollEnabled = false
            self.txtVwChat.frame.size.height = self.txtViewCommentMinHeight
            self.txtVwChat.text = ""
            
            if self.txtVwChat.text!.count > 0{
                
                self.txtVwChat.isScrollEnabled = false
                
            }else{
                self.txtVwChat.isScrollEnabled = false
            }
            
        }else{
            
         
            self.txtVwChat.frame.size.height = self.txtViewCommentMinHeight
            DispatchQueue.main.async {
                let text  = self.txtVwChat.text!//.encodeEmoji
                self.sendMessageNew(strText: text)
            }
            if self.txtVwChat.text!.count > 0{
                self.txtVwChat.isScrollEnabled = false
                
            }else{
                self.txtVwChat.isScrollEnabled = false
            }
        }
        
    }

}


//MARK:- UItextViewHeightManage
extension ChatListVC: UITextViewDelegate{
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        return newText.count <= 150
    }
    
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
          if self.txtVwChat.text == "\n"{
              self.txtVwChat.resignFirstResponder()
          }
          else{
          }
          return true
      }
      
    func textViewDidEndEditing(_ textView: UITextView) {
       
    }
      
      func textViewDidChange(_ textView: UITextView)
      {
          if self.txtVwChat.contentSize.height >= self.txtViewCommentMaxHeight
          {
              self.txtVwChat.isScrollEnabled = true
          }
          else
          {
              self.txtVwChat.frame.size.height = self.txtVwChat.contentSize.height
              self.txtVwChat.isScrollEnabled = false
          }
      }
      
    
    
    func sendMessageNew(strText:String){
        self.txtVwChat.isScrollEnabled = false
        self.txtVwChat.contentSize.height = self.txtViewCommentMinHeight
        self.txtVwChat.text = self.txtVwChat.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if self.txtVwChat.text == "" {
           // AppSharedClass.shared.showAlert(title: "Alert", message: "Please enter some text", view: self)
            return
        }else{
            self.call_SendTextMessageOnly(strUserID: "", strText: "Hello iOS First Chat Message")
           //asd self.call_WSSendMessage(strSenderID: self.getSenderID, strMessage: self.txtVwChat.text)
        }
        self.txtVwChat.text = ""
    }
    
}


extension ChatListVC{
    
    func call_GetChat(){
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
        objWebServiceManager.showIndicator()
       
        let dict = AppSharedData.getUserInfo()
        let url  = WsUrl.url_getChat+"?receiver_id=1&sender_id=2" //\(dict["user_id"] ?? "")
        
        objWebServiceManager.requestGet(strURL: url, params: [:], queryParams: [:], strCustomValidation: "") { [self] (response) in
            objWebServiceManager.hideIndicator()
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            print(response)
            if status == MessageConstant.k_StatusCode{
                if let user_details  = response["result"] as? [[String:Any]] {
                    print("user_details>>>>>\(user_details)")
                    
                    for data in user_details{
                        let obj = ChatDetailModel.init(dict: data)
                        self.arrChatMsg.append(obj)
                    }
                 //   self.arrChatMsg = user_details.mutableCopy() as! NSMutableArray
                    if self.arrChatMsg.count > 0 {
                        self.tblChatList.displayBackgroundText(text: "")
                    }else{
                        self.tblChatList.displayBackgroundText(text: "No Chat Found")
                    }
                    self.tblChatList.reloadData()
                }
                else {
                    objAlert.showAlert(message: "Something went wrong!", title: "", controller: self)
                }
            }else{
                objWebServiceManager.hideIndicator()
                if let msgg = response["result"]as? String{
                    objAlert.showAlert(message: msgg, title: "", controller: self)
                }else{
                    objAlert.showAlert(message: message ?? "", title: "", controller: self)
                }
            }
        } failure: { (Error) in
            objWebServiceManager.hideIndicator()
        }
    }
    
    
    //MARK:- Send CHat Message
    
    //MARK:- Send Text message Only
    
    func call_SendTextMessageOnly(strUserID:String, strText:String){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
    
       // objWebServiceManager.showIndicator()
        
        let receiverId = dictPrevious.GetString(forKey: "receiver_id")
        let senderId = dictPrevious.GetString(forKey: "sender_id")
        
        let dicrParam = ["receiver_id":receiverId,//Opponent ID
                         "sender_id":senderId,//My ID
                         "type":"text",
                         "chat_message":strText]as [String:Any]
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_insertChat, queryParams: [:], params: dicrParam, strCustomValidation: "", showIndicator: false) { (response) in
            objWebServiceManager.hideIndicator()
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            
            print(response)
            
            if let result = response["result"]as? String{
                if result == "successful"{
                   // self.isSendMessage = true
                    //self.initilizeFirstTimeOnly = false
                   // self.call_GetChatList(strUserID: objAppShareData.UserDetail.strUserId, strSenderID: self.strSenderID)
                }
            }else{
                objWebServiceManager.hideIndicator()
               // objAlert.showAlert(message: message ?? "", title: "Alert", controller: self)
                
            }
           
            
        } failure: { (Error) in
            print(Error)
            objWebServiceManager.hideIndicator()
        }
   }
}

class ChatListCell:UITableViewCell {
    
    @IBOutlet weak var vwOpponent: UIView!
    @IBOutlet weak var vwMyMsg: UIView!
    @IBOutlet weak var lblOpponentMsg: UILabel!
    @IBOutlet weak var lblopponentMsgTime: UILabel!
    @IBOutlet weak var lblMyMsg: UILabel!
    @IBOutlet weak var lblMyMsgTime: UILabel!
    
}
