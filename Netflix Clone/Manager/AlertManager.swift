
import UIKit

class AlertManager {
    
    private static func showBasicAlert(on vc: UIViewController, title: String, message: String?) {
        
        
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            
            vc.present(alert, animated: true, completion: nil)
            
        }
    }
}

// Invalid entry errors
extension AlertManager {
    
    public static func showValidEmailAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Invalid Email!", message: "Please enter a valid email.")
    }
    
    public static func showValidPasswordAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Invalid Password!", message: "Please enter a valid password.")
    }
    
    
}

// Register errors
extension AlertManager {
    public static func showRegistrationErrorAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Unknown Registration Error!", message: nil)
        
    }
    public static func showRegistrationErrorAlert(on vc: UIViewController, with error: Error) {
        self.showBasicAlert(on: vc, title: "Unknown Registration Error!", message: "\(error.localizedDescription)")
        
    }
    
    public static func showUnmatchPasswordErrorAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Unmatched Password", message: "The passwords does not match.")
    }
}


// Log in errors
extension AlertManager {
    public static func showSignInErrorAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Unknown Error Signing In!", message: nil)
        
    }
    
    public static func showSignInErrorAlert(on vc: UIViewController, with error: Error) {
        self.showBasicAlert(on: vc, title: "Unknown Error Signing In!", message: "\(error.localizedDescription)")
        
    }
}

// Log out errors
extension AlertManager {
    public static func showLogoutErrorAlert(on vc: UIViewController, with error: Error) {
        self.showBasicAlert(on: vc, title: "Log Out Error", message: "\(error.localizedDescription)")
    }
}
