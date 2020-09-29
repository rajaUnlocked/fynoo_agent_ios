//
//  ServerCalls.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-049 on 11/09/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit
import Alamofire

class ServerCalls: NSObject {
    static func PdfFileUpload(inputUrl:String,parameters:[String:Any],pdfname: String,pdfurl:String,completion:((AnyObject?,Bool,AnyObject?) -> Void)?){
           
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            if pdfurl != ""{
                let url = URL(string: pdfurl)
                let pdfData = try! Data(contentsOf: url!.asURL())
                
                multipartFormData.append(pdfData, withName: pdfname, fileName: pdfname, mimeType:"application/pdf")
            }
            
            
            
            for (key, value) in parameters {
                let val = "\(value)"
                multipartFormData.append(val.data(using: String.Encoding.utf8)!, withName: key)
                print("key",key,"value",val)
            }
            print("aa",multipartFormData)
            
        }, to:inputUrl)
           { (result) in
               switch result {
               case .success(let upload, _, _ ):
                   upload.uploadProgress(closure: { (progress) in
                       print("Upload Progress: \(progress.fractionCompleted)")
                   })
                   upload.responseJSON { response in
                       print(response.result.value)
                       completion!(response.result.value as AnyObject,true,response.data as AnyObject)
                   }
               case .failure(let encodingError):
                   completion!(nil,false,nil)
               }
           }
           
       }
    
    static func fileVideoUploadAPINew(inputUrl:String,parameters:[String:Any],imageName: String,imageFile:UIImage,videourl:URL,completion:((AnyObject?,Bool,AnyObject?) -> Void)?){
        
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
        for key in parameters.keys{
                       let name = String(key)
                       if let val = parameters[name] as? String{
                           multipartFormData.append(val.data(using: .utf8)!, withName: name)
                       }
                   }
                let imageData = imageFile.jpegData(compressionQuality : 1)
                multipartFormData.append(videourl, withName:imageName, fileName: "file.mp4", mimeType: "video/mp4")
            multipartFormData.append(imageData!, withName: "thumbnail", fileName: "file.jpg", mimeType: "image/jpg")
         
            
           
        }, to:inputUrl)
        { (result) in
            switch result {
            case .success(let upload, _, _ ):
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                upload.responseJSON { response in
                    print(response.result.value)
                    completion!(response.result.value as AnyObject,true,response.data as AnyObject)
                }
            case .failure(let encodingError):
                completion!(nil,false,nil)
            }
        }
        
    }
    
    static func postRequestss(_ urlString: String, withParameters: Parameters , completion: ((AnyObject?,Bool,AnyObject?) -> Void)?)
        
    {
        
        print(urlString)
        
        Alamofire.request("\(urlString)", method:.post, parameters: withParameters, encoding: URLEncoding.default).validate().responseJSON {
            
            response in
            
            switch response.result {
                
            case .failure(let error):
                
                print(error)
                
                ModalClass.stopLoading()
                
                completion!(nil,false,nil)
                
            case .success(let responseObject):
                
                print("response is success:  \(responseObject)")
                
                completion!(response.result.value as AnyObject,true,response.data as AnyObject)
                
            }
            
        }
        
    }
    
    static func fileUploadAPINewMultipleImage(inputUrl:String,parameters:[String:Any],imageName: String,imageFile : [UIImage],completion:((AnyObject?,Bool,AnyObject?) -> Void)?){
        
        print( imageFile.count)
       
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            for i in 0..<imageFile.count{
                let selectedImageNew = imageFile[i].resizeWithWidth(width: 800)!
                let compressData = selectedImageNew.jpegData(compressionQuality: 0.8) //max value is 1.0 and
                multipartFormData.append(compressData!, withName: imageName, fileName: "file.jpg", mimeType: "image/jpg")
            }
            
            
           
            
            
            for (key, value) in parameters {
                let val = "\(value)"
                multipartFormData.append(val.data(using: String.Encoding.utf8)!, withName: key)
                print("key",key,"value",val)
            }
            print("aa",multipartFormData)

        }, to:inputUrl)
        { (result) in
            switch result {
            case .success(let upload, _, _ ):
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                upload.responseJSON { response in
                    print(response.result.value)
                    completion!(response.result.value as AnyObject,true,response.data as AnyObject)
                }
            case .failure(let encodingError):
                completion!(nil,false,nil)
            }
        }
        
    }
    
    
    
    
    
    
    
    
    
    static func fileUploadAPINew(inputUrl:String,parameters:[String:Any],imageName: String,imageFile : UIImage,completion:((AnyObject?,Bool,AnyObject?) -> Void)?){
        
        print(inputUrl)
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            
            
            let imageData = imageFile.jpegData(compressionQuality : 1)
            multipartFormData.append(imageData!, withName: imageName, fileName: "file.jpg", mimeType: "image/jpg")
            
            
            for (key, value) in parameters {
                let val = "\(value)"
                multipartFormData.append(val.data(using: String.Encoding.utf8)!, withName: key)
                print("key",key,"value",val)
            }
            print("aa",multipartFormData)

        }, to:inputUrl)
        { (result) in
            switch result {
            case .success(let upload, _, _ ):
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                upload.responseJSON { response in
                    print(response.result.value)
                    completion!(response.result.value as AnyObject,true,response.data as AnyObject)
                }
            case .failure(let encodingError):
                completion!(nil,false,nil)
            }
        }
        
    }
    
    static func fileUploadAPI(Imgtype: String,imagefrom:String ,img : UIImage, completion: ((AnyObject?,Bool,AnyObject?) -> Void)?)
    {
        let parameters = ["image_from":imagefrom,
                       "image_type":Imgtype,
        "lang_code":HeaderHeightSingleton.shared.LanguageSelected]
        let tempImage = img
    let imageData = tempImage.jpegData(compressionQuality : 1)
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData!, withName: "image",fileName: "file.jpg", mimeType: "image/jpg")
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            } //Optional for extra parameters
            
        }, to:"\(Constant.BASE_URL)\(Constant.upload_file)")
            
        { (result) in
            switch result {
            case .success(let upload, _, _ ):
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                upload.responseJSON { response in
                    print(response.result.value)
                    completion!(response.result.value as AnyObject,true,response.data as AnyObject)
                }
            case .failure(let encodingError):
                completion!(nil,false,nil)
            }
        }
    }

    
//    static func fileUploadAPI(Imgtype: String,imagefrom:String ,img : UIImage, completion: ((AnyObject?,Bool,AnyObject?) -> Void)?)
//    {
//        let parameters = ["image_from":imagefrom,
//                       "image_type":Imgtype,
//        "lang_code":HeaderHeightSingleton.shared.LanguageSelected]
//        let tempImage = img
//    let imageData = tempImage.jpegData(compressionQuality : 1)
//
//        Alamofire.upload(multipartFormData: { multipartFormData in
//            multipartFormData.append(imageData!, withName: "image",fileName: "file.jpg", mimeType: "image/jpg")
//            for (key, value) in parameters {
//                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
//            } //Optional for extra parameters
//
//        }, to:"\(Constant.BASE_URL)\(Constant.upload_file)")
//
//        { (result) in
//            switch result {
//            case .success(let upload, _, _ ):
//                upload.uploadProgress(closure: { (progress) in
//                    print("Upload Progress: \(progress.fractionCompleted)")
//                })
//                upload.responseJSON { response in
//                    print(response.result.value)
//                    completion!(response.result.value as AnyObject,true,response.data as AnyObject)
//                }
//            case .failure(let encodingError):
//                completion!(nil,false,nil)
//            }
//        }
//    }
    
//     static func fileVideoUploadAPI(Imgtype: String,imagefrom:String ,Videourl : URL, completion: ((AnyObject?,Bool,AnyObject?) -> Void)?)
//    {
//        let timestamp = NSDate().timeIntervalSince1970
//    let parameters = ["image_from":imagefrom,
//                      "image_type":Imgtype,"branch_id" :AddBranch.shared.BranchId,"lang_code":HeaderHeightSingleton.shared.LanguageSelected]
//
//        Alamofire.upload(
//            multipartFormData: { multipartFormData in
//                multipartFormData.append(Videourl, withName: "image", fileName: "\(timestamp).mp4", mimeType: "\(timestamp)/mp4")
//    for (key, value) in parameters {
//    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
//    } //Optional for extra parameters
//
//    }, to:"\(Constant.BASE_URL)\(Constant.upload_file)")
//
//    { (result) in
//    switch result {
//    case .success(let upload, _, _ ):
//    upload.uploadProgress(closure: { (progress) in
//    print("Upload Progress: \(progress.fractionCompleted)")
//    })
//    upload.responseJSON { response in
//    print(response.result.value)
//    completion!(response.result.value as AnyObject,true,response.data as AnyObject)
//    }
//    case .failure(let encodingError):
//    completion!(nil,false,nil)
//    }
//    }
//    }
    
   static func postRequest(_ urlString: String, withParameters: Parameters , completion: ((AnyObject?,Bool,AnyObject?) -> Void)?)
    {
        print(urlString)
        Alamofire.request("\(urlString)", method:.post, parameters: withParameters, encoding: URLEncoding.default).validate().responseJSON {
            response in
            switch response.result {
            case .failure(let error):
                print(error)
                ModalClass.stopLoading()
                completion!(nil,false,nil)
            case .success(let responseObject):
                print("response is success:  \(responseObject)")
                completion!(response.result.value as AnyObject,true,response.data as AnyObject)
            }
        }
    }
 
      
    static func postRequestRAW(_ urlString: String, JsonString: String , completion: ((AnyObject?,Bool,AnyObject?) -> Void)?)
    {
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let pjson = JsonString
        let data = (pjson.data(using: .utf8))! as Data
        
        request.httpBody = data
        
        Alamofire.request(request).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                print(error)
                completion!(nil,false, nil)
            case .success(let responseObject):
                print("response is success:  \(responseObject)")
               completion!(response.result.value as AnyObject,true,response.data as AnyObject)
            }
        }
    }
    
    static func getRequests(_ urlString: String, completion: ((AnyObject?,Bool) -> Void)?)
        
    {
        
        
        
        print(urlString)
        
        
        
        Alamofire.request("\(urlString)", method:.get, parameters: nil, encoding: URLEncoding.default).validate().responseJSON {
            
            response in
            
            switch response.result {
                
            case .failure(let error):
                
                print(error)
                
                completion!(nil,false)
                
                //               ModalController.showNegativeCustomAlertWith(title: "Connection error", msg: "")
                
            case .success(let responseObject):
                
                print("response is success:  \(responseObject)")
                
                completion!(response.result.value as AnyObject,true)
                
            }
            
        }
        
    }
    
    static func getRequest(_ urlString: String, completion: ((AnyObject?,Bool,AnyObject?) -> Void)?){
        Alamofire.request("\(urlString)", method:.get, parameters: nil, encoding: URLEncoding.default).validate().responseJSON {
            response in
            
            switch response.result {
            case .failure(let error):
                
                print(error)
                completion!(nil,false,nil)
            case .success(let responseObject):
               print("response is success:  \(responseObject)")
            completion!(response.result.value as AnyObject,true,response.data as AnyObject)
            }
        }
    }
  
    
    static func getRequestWithBody(_ urlString: String, completion: ((AnyObject?,Bool) -> Void)?){
        let params: [String: Any] = ["lang_code": "en"]
        print(urlString)
        Alamofire.request("\(urlString)", method:.get, parameters: params, encoding: URLEncoding.default).validate().responseJSON {
            response in
            switch response.result {
            case .failure(let error):
                
                print(error)
                completion!(nil,false)
                
            case .success(let responseObject):
                print("response is success:  \(responseObject)")
                completion!(response.result.value as AnyObject,true)
            }
            
        }
        
    }
    
    static func postRequest(_ urlString: String, withParameters: Parameters , completion: ((AnyObject?,Bool) -> Void)?)
    {
        
        
        Alamofire.request("\(urlString)", method:.post, parameters: withParameters, encoding: URLEncoding.default).validate().responseJSON {
            response in
            switch response.result {
            case .failure(let error):
                print(error)
                completion!(nil,false)
            //               ModalController.showNegativeCustomAlertWith(title: "Connection error", msg: "")
            case .success(let responseObject):
                print("response is success:  \(responseObject)")
                completion!(response.result.value as AnyObject,true)
            }
        }
    }
    static func putRequest(_ urlString: String, withParameters: Parameters , completion: ((AnyObject?,Bool) -> Void)?)
      {
          
          
          Alamofire.request("\(urlString)", method:.put, parameters: withParameters, encoding: URLEncoding.default).validate().responseJSON {
              response in
              switch response.result {
              case .failure(let error):
                  print(error)
                  completion!(nil,false)
              //               ModalController.showNegativeCustomAlertWith(title: "Connection error", msg: "")
              case .success(let responseObject):
                  print("response is success:  \(responseObject)")
                  completion!(response.result.value as AnyObject,true)
              }
          }
      }
    static func makePostRequestWithToken(_ urlString: String, withParameters: String , completion: ((AnyObject?,Bool) -> Void)?)

       {

           let todoEndpoint: String = urlString
           let post :  String = withParameters
           var request = URLRequest(url: URL(string: todoEndpoint)!)
           //     request.setValue("application/json", forHTTPHeaderField: "Accept")
           //    request.setValue("Bearer \(ModalController.getTheContentForKey("userToken") as! String)", forHTTPHeaderField: "Authorization")
           request.httpBody = post.data(using: String.Encoding.ascii, allowLossyConversion: true)
           request.setValue("application/json", forHTTPHeaderField: "Content-Type")
           request.httpMethod = "POST"
           Alamofire.request(request as URLRequestConvertible).responseJSON { response in
               guard response.result.error == nil else {
              // got an error in getting the data, need to handle it

                   completion!(nil,false)
                   print("error calling GET on /todos/1")
                   print(response.result.error!)
                   return
               }
               // make sure we got some JSON since that's what we expect
               guard let json = response.result.value as? [String: Any] else {
                   completion!(response as AnyObject,false)
                   print("didn't get todo object as JSON from API")
                   print("Error: \(String(describing: response.result.error))")
                   return
            }

               completion!(json as AnyObject,true)

        }
       }
}
