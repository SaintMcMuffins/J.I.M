// Home screen for application.


import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // check if there is a logged in user
        guard let _ = User.getLoggedInUser() else {
            // if there isn't a logged in user, navigate to the login page
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.navigationController?.pushViewController(loginVC, animated: true)
            return
        }
    }

    @IBAction func homeButtonTapped(_ sender: Any) {
        // do something when the home button is tapped
    }

    @IBAction func workoutButtonTapped(_ sender: Any) {
        // do something when the workout button is tapped
    }

    @IBAction func myProfileButtonTapped(_ sender: Any) {
        // do something when the my profile button is tapped
    }

    @IBAction func calendarButtonTapped(_ sender: Any) {
        // navigate to the calendar page
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let calendarVC = storyboard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
        self.navigationController?.pushViewController(calendarVC, animated: true)
    }
}
