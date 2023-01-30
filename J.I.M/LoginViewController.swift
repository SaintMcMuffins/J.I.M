import UIKit
import CoreData

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rememberMeSwitch: UISwitch!
    @IBOutlet weak var faceIDLoginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // check if the user has turned on the remember me feature
        if UserDefaults.standard.bool(forKey: "rememberMe") {
            emailTextField.text = UserDefaults.standard.string(forKey: "email")
            rememberMeSwitch.isOn = true
        }
    }

    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            // show an alert to inform the user that all fields are required
            return
        }

        let request = User.fetchRequest() as NSFetchRequest<User>
        request.predicate = NSPredicate(format: "email == %@", email)
        do {
            let users = try PersistenceService.context.fetch(request)
            if let user = users.first, user.password == password {
                user.isLoggedIn = true
                PersistenceService.saveContext()

                // save the email if the remember me switch is on
                if rememberMeSwitch.isOn {
                    UserDefaults.standard.set(email, forKey: "email")
                    UserDefaults.standard.set(true, forKey: "rememberMe")
                } else {
                    UserDefaults.standard.removeObject(forKey: "email")
                    UserDefaults.standard.set(false, forKey: "rememberMe")
                }

                // navigate to the home page
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                self.navigationController?.pushViewController(homeVC, animated: true)
            } else {
                // show an alert to inform the user that the email or password is incorrect
            }
        } catch {
            print("Error fetching user: \(error)")
        }
    }
    @IBAction func faceIDLoginTapped(_ sender: Any) {
        // Implement Face ID login here
        // You can use LocalAuthentication framework to implement Face ID.
    }
}
