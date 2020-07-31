//
//  MainViewModel.swift
//  MobileAxxessTest
//
//  Created by devang bhavsar on 30/07/20.
//  Copyright © 2020 devang bhavsar. All rights reserved.
//

import UIKit
import SDWebImage
class MainViewModel: NSObject {
    var apisuccessMessage:TAAPISuccess?
    var apiFailedMessage:TAAPIFailed?
    var arrMainData = [MainModel]()
    //MARK:- API request Registration
    func getAllData(){
        do
        {
            let getInfo = baseURL//baseURL + signupAPI
            DispatchQueue.global(qos: .userInitiated).async {
                APIRequest.shared.getAPIRequest(serviceName: getInfo, completionBlockSuccess: { (mm:[MainModel]) in
                    self.arrMainData = mm
                    self.apisuccessMessage!(ksuccess)
                }) { (value) in
                    self.apiFailedMessage!(value as! String)
                }
            }
        }
    }
}
extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let objData = objMainViewModel.arrMainData[indexPath.row]
        
        
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            if objData.type == "image" {
                     return 250.0
                 }else {
                     if let newValue = objData.data {
                         let length = newValue.height(withConstrainedWidth: screenWidth - 60.0, font: .systemFont(ofSize: 20.0))
                         if length < 30 {
                             return 100.0
                         }else {
                              return length + 30
                         }
                     } else {
                         return 70.0
                     }
                    
                 }
            break
              // It's an iPhone
        case .pad:
            if objData.type == "image" {
                     return 400.0
                 }else {
                     if let newValue = objData.data {
                         let length = newValue.height(withConstrainedWidth: screenWidth - 60.0, font: .systemFont(ofSize: 25.0))
                         if length < 50 {
                            return 200.0
                         }else {
                              return length + 80
                         }
                     } else {
                         return 150.0
                     }
                    
                 }
            break
              // It's an iPad (or macOS Catalyst)
        case .unspecified: break
              // Uh, oh! What could it be?
        @unknown default:
            break
        }
        
     return 0
      
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objMainViewModel.arrMainData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let objData = objMainViewModel.arrMainData[indexPath.row]
        if objData.type == "image" {
            let cell = tblDisplay.dequeueReusableCell(withIdentifier: "ImageTableViewCell")   as! ImageTableViewCell
            if let date = objData.date {
                cell.lblDate.text = date
            }
            if let imageUrl:String = objData.data {
                      cell.imgDisplay?.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "placeholderImage"))
            }
            cell.selectionStyle = .none
            return cell
        }
        else {
            let cell2 = tblDisplay.dequeueReusableCell(withIdentifier: "TextDescriptionTableViewCell") as! TextDescriptionTableViewCell
            if let date = objData.date {
                cell2.lblDate.text = date
            }
            if let data:String = objData.data {
                cell2.lblDescription.text = data
            }
            cell2.selectionStyle = .none
            return cell2
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objData = objMainViewModel.arrMainData[indexPath.row]
        if objData.type == "image" {
            if let strImage = objData.data {
                self.displayImageView(imageName:strImage)
            }else {
                 self.displayImageView(imageName:"")
            }
        }else {
            if let strDate = objData.data {
                self.displayDataFullScreen(data:strDate)
            } else {
                 self.displayDataFullScreen(data:"")
            }
            
        }
    }
    
}
extension ViewController {
    func displayImageView(imageName:String)  {
        let objImage = UIStoryboard(name: MainStoryBoard, bundle: nil).instantiateViewController(identifier: "ImageDisplayViewController") as! ImageDisplayViewController
        objImage.isModalInPresentation = true
        objImage.modalPresentationStyle = .overFullScreen
        objImage.imageName = imageName
        self.present(objImage, animated: true, completion: nil)
    }
    func displayDataFullScreen(data:String) {
        let objDisplayData = UIStoryboard(name: MainStoryBoard, bundle: nil).instantiateViewController(identifier: "DescriptionVC") as! DescriptionVC
        objDisplayData.isModalInPresentation = true
        objDisplayData.modalPresentationStyle = .overFullScreen
        objDisplayData.strDescription = data
        self.present(objDisplayData, animated: true, completion: nil)
    }
}
