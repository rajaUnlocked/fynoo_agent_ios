import UIKit
protocol OpenGalleryDelegate {
    func gallery(img:UIImage,imgtype:String)
  
}

class OpenGallery:NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    var view:UIView?
    var viewControl = UIViewController()
    static let shared = OpenGallery()
    var seletedImg = UIImage()
    var imgType = ""
    var delegate:OpenGalleryDelegate?
    private override init() {
        
    }
    func openCamera()
    {
        let imagePicker = UIImagePickerController()
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            viewControl.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            viewControl.present(alert, animated: true, completion: nil)
        }
    }
    func  openGallery()
    {
        let imagePicker = UIImagePickerController()
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            viewControl.present(imagePicker, animated: true, completion: nil)
        }
    }
    func uploadImgAction() {
        //  view = vw
        let alert = UIAlertController(title: "Message", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (action) in
            self.openGallery()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        viewControl.present(alert, animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        viewControl.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("Image not found!")
            
            return
        }
       
        seletedImg = selectedImage
        let selectedImageNew = selectedImage.resizeWithWidth(width: 800)!
        let compressData = selectedImageNew.jpegData(compressionQuality: 0.8) //max value is 1.0 and minimum is 0.0
        let compressedImage = UIImage(data: compressData!)
        viewControl.dismiss(animated: true) {
            self.delegate?.gallery(img: compressedImage!, imgtype: self.imgType)
        }
    }
}
