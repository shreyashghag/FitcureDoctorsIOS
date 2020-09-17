
import UIKit

extension EditProfileVC: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        guard let img = image else {
            self.imgvProfile.image = UIImage(named: "f_FitcureLogo")!
            self.media = nil
            return
        }
        DispatchQueue.main.async {
            self.imgvProfile.image = img
            self.media  =  APICall.Media(withImage: img, forKey: "images", andFileName: "\(UserData.returnValue(.Mobile) ?? "")_Doctor_Profile.png")
            
        }
    }
}
