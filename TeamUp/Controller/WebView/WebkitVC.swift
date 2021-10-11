//
//  WebkitVC.swift
//  TeamUp
//
//  Created by Apple on 29/09/21.
//

import UIKit
import WebKit

class WebkitVC: UIViewController,WKUIDelegate {

    @IBOutlet weak var webKitView: WKWebView!
    var strTitle = String()
    var intType = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = strTitle
        self.webKitView.uiDelegate = self
        if intType == 2 {
        let fileUrl = URL(string: WsUrl.url_Terms)
        self.webKitView.load(URLRequest(url:fileUrl!))
        }else if intType == 3 {
        let fileUrl = URL(string: WsUrl.url_About)
        self.webKitView.load(URLRequest(url:fileUrl!))
        }
    }
    

    

}
