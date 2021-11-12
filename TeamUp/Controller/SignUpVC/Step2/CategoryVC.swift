//
//  CategoryVC.swift
//  TeamUp
//
//  Created by Apple on 28/09/21.
//

import UIKit


protocol myCategoryDelegate {
    func getMyCategory(strTitle:String,strId:String,strType: String)
}

class CategoryVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tblCategoryList: UITableView!
    var arrCategory = NSMutableArray()
    var arrProfessionCategory = NSMutableArray()
    var delegate:myCategoryDelegate?
    var arrSubCategory = NSMutableArray()
    
    var strType = ""
    
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
        if strType == "SubCat" {
            return arrSubCategory.count
        }else if strType == "proffesion"{
            return self.arrProfessionCategory.count
        }
        else{
        return arrCategory.count
        }
        return Int()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTblCell") as! CategoryTblCell
        var dict = NSDictionary()
        if strType == "SubCat" {
            dict = arrSubCategory[indexPath.row] as! NSDictionary
            let title = dict.value(forKey: "sub_category_name")
              cell.lblTitle.text! = title as! String
        }else if strType == "proffesion"{
            dict = arrProfessionCategory[indexPath.row] as! NSDictionary
            let title = dict.value(forKey: "profession_category_name")
              cell.lblTitle.text! = title as! String
        }
        else{
            dict = arrCategory[indexPath.row] as! NSDictionary
            let title = dict.value(forKey: "category_name")
              cell.lblTitle.text! = title as! String
        }
      
           let status = dict.GetInt(forKey: "status")
            if status == 0 {
                cell.imgCheckBox.image = UIImage(named: "check")
            } else if status  == 1 {
                cell.imgCheckBox.image = UIImage(named: "box")
            }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if strType == "SubCat" {
        let dict = arrSubCategory[indexPath.row] as? NSDictionary
        let category_name = dict?.GetString(forKey: "sub_category_name")
        let sub_category_id = dict?.GetString(forKey: "sub_category_id")
        let entrydt = dict?.GetString(forKey: "entrydt")
        let category_id = dict?.GetInt(forKey: "category_id")
        let status = dict?.GetInt(forKey: "status")
        var dictData = NSMutableDictionary()
        dictData.setValue(category_name, forKey: "sub_category_name")
        dictData.setValue(entrydt, forKey: "entrydt")
        dictData.setValue(sub_category_id, forKey: "sub_category_id")
        dictData.setValue(category_id, forKey: "category_id")
        dictData.setValue(status, forKey: "status")
            if status == 1 {
                dictData.setValue(0, forKey: "status")
            }else if status == 0 {
                dictData.setValue(1, forKey: "status")
            }
            self.arrSubCategory.replaceObject(at: indexPath.row, with:dictData)
            self.tblCategoryList.reloadData()
            
        }else if strType == "proffesion"{
            
            let dict = arrProfessionCategory[indexPath.row] as? NSDictionary
            let category_name = dict?.GetString(forKey: "profession_category_name")
            let sub_category_id = dict?.GetString(forKey: "profession_category_id")
            let entrydt = dict?.GetString(forKey: "entrydt")
           // let category_id = dict?.GetInt(forKey: "category_id")
            let status = dict?.GetInt(forKey: "status")
            var dictData = NSMutableDictionary()
            dictData.setValue(category_name, forKey: "profession_category_name")
            dictData.setValue(entrydt, forKey: "entrydt")
            dictData.setValue(sub_category_id, forKey: "profession_category_id")
          //  dictData.setValue(category_id, forKey: "category_id")
            dictData.setValue(status, forKey: "status")
                if status == 1 {
                    dictData.setValue(0, forKey: "status")
                }else if status == 0 {
                    dictData.setValue(1, forKey: "status")
                }
                self.arrProfessionCategory.replaceObject(at: indexPath.row, with:dictData)
                self.tblCategoryList.reloadData()
            
        }
        else{
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
    }
   

    @IBAction func btnCross(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    @IBAction func btnDone(_ sender: Any) {
        var strId = String()
        var strTitle = String()
        if strType == "SubCat" {
            for i in 0..<arrSubCategory.count {
                let dict = arrSubCategory.getNSDictionary(atIndex: i)
                let status = dict.GetInt(forKey: "status")
                let catId = dict.GetInt(forKey: "sub_category_id")
                let strCat = dict.GetString(forKey: "sub_category_name")
                if status == 0 {
                    strId = strId == "" ?"\(catId)" :"\(strId),\(catId)"
                    strTitle = strTitle == "" ?strCat :"\(strTitle),\(strCat)"
                }
            }
        }else if strType == "proffesion"{
            for i in 0..<arrProfessionCategory.count {
                let dict = arrProfessionCategory.getNSDictionary(atIndex: i)
                let status = dict.GetInt(forKey: "status")
                let catId = dict.GetInt(forKey: "profession_category_id")
                let strCat = dict.GetString(forKey: "profession_category_name")
                if status == 0 {
                    strId = strId == "" ?"\(catId)" :"\(strId),\(catId)"
                    strTitle = strTitle == "" ?strCat :"\(strTitle),\(strCat)"
                }
            }
        }
        else{
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
        }
        
        self.delegate?.getMyCategory(strTitle: strTitle, strId: strId, strType: self.strType)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
   

    
}

class CategoryTblCell:UITableViewCell {
    
    @IBOutlet weak var imgCheckBox: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
}
