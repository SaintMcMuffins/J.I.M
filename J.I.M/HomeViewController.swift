// Home screen for application.


import UIKit

class HomeViewController: UIViewController {
    var welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(welcomeLabel)
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])

        // check if there is a logged in user
        guard let loggedInUser = User.getLoggedInUser() else {
            // if there isn't a logged in user, navigate to the login page
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.navigationController?.pushViewController(loginVC, animated: true)
            return
        }

        welcomeLabel.text = "Welcome Back, \(loggedInUser.username)"
    }



    @IBAction func homeButtonTapped(_ sender: Any) {
        // do something when the home button is tapped
    }

    @IBAction func workoutButtonTapped(_ sender: Any) {
        // do something when the workout button is tapped
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let workoutVC = storyboard.instantiateViewController(withIdentifier: "WorkoutViewController") as! WorkoutViewController
        self.navigationController?.pushViewController(workoutVC, animated: true)
    }

    @IBAction func myProfileButtonTapped(_ sender: Any) {
        // navigate to my profile page
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myProfileVC = storyboard.instantiateViewController(withIdentifier: "MyProfileViewController") as! MyProfileViewController
        self.navigationController?.pushViewController(myProfileVC, animated: true)
    }

    @IBAction func calendarButtonTapped(_ sender: Any) {
        // navigate to the calendar page
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let calendarVC = storyboard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
        self.navigationController?.pushViewController(calendarVC, animated: true)
    }
}