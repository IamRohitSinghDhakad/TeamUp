//
//  CategoryVC.swift
//  TeamUp
//
//  Created by Apple on 28/09/21.
//

import UIKit


protocol myCategoryDelegate {
    func getMyCategory(strTitle:String,strId:String)
}

class CategoryVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tblCategoryList: UITableView!
    var arrCategory = NSMutableArray()
    
    var delegate:myCategoryDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDelegate()
    }
    
    func setDelegate() {
        self.tblCategoryList.delegate = self
        self.tblCategoryList.dataSource = self
        self.tblCategoryList.reloadData()
    }
    
    // MARK: - TableViewDelegate&Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTblCell") as! CategoryTblCell
        let dict = arrCategory[indexPath.row] as? NSDictionary
        print("dict>>>>>>\(dict)")
        if let title = dict?.value(forKey: "category_name") {
            cell.lblTitle.text! = title as! String
        }
      
        if let status = dict?.GetInt(forKey: "status") {
            if status == 0 {
                cell.imgCheckBox.image = UIImage(named: "check")
            } else if status  == 1 {
                cell.imgCheckBox.image = UIImage(named: "box")
            }
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = arrCategory[indexPath.row] as? NSDictionary
        let category_name = dict?.GetString(forKey: "category_name")
        let category_image = dict?.GetString(forKey: "category_image")
        let category_id = dict?.GetInt(forKey: "category_id")
        let status = dict?.GetInt(forKey: "status")
        var dictData = NSMutableDictionary()
        dictData.setValue(category_name, forKey: "category_name")
        dictData.setValue(category_image, forKey: "category_image")
        dictData.setValue(category_id, forKey: "category_id")
        dictData.setValue(status, forKey: "status")
       
            if status == 1 {
                dictData.setValue(0, forKey: "status")
            }else if status == 0 {
                dictData.setValue(1, forKey: "status")
            }
            self.arrCategory.replaceObject(at: indexPath.row, with:dictData)
            self.tblCategoryList.reloadData()
    
      
    }

    @IBAction func btnCross(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    @IBAction func btnDone(_ sender: Any) {
        var strId = String()
        var strTitle = String()
         for i in 0..<arrCategory.count {
         let dict = arrCategory.getNSDictionary(atIndex: i)
         let status = dict.GetInt(forKey: "status")
         let catId = dict.GetInt(forKey: "category_id")
            
         let strCat = dict.GetString(forKey: "category_name")
          if status == 0 {
              strId = strId == "" ?"\(catId)" :"\(strId),\(catId)"
              strTitle = strTitle == "" ?strCat :"\(strTitle),\(strCat)"
          }
       }
        self.delegate?.getMyCategory(strTitle: strTitle, strId: strId)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
   

    
}

class CategoryTblCell:UITableViewCell {
    
    @IBOutlet weak var imgCheckBox: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
}
