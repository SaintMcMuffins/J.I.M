import UIKit
import CoreData

class RegisterViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func registerButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            //show an alert to inform the user that all fields are required
            return
        }

        let user = User(coder: PersistenceService.context)
        user.name = name
        user.email = email
        user.password = password

        PersistenceService.saveContext()

        // navigate to the calendar page
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let calendarVC = storyboard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
        self.navigationController?.pushViewController(calendarVC, animated: true)
    }
}
