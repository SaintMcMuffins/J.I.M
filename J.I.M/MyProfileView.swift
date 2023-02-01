// Screen for user's profile page.


import Foundation
import UIKit

class MyProfileViewController: UIViewController {

@IBOutlet weak var profileImageView: UIImageView!
@IBOutlet weak var nameLabel: UILabel!
@IBOutlet weak var experienceLevelLabel: UILabel!
@IBOutlet weak var weightLabel: UILabel!
@IBOutlet weak var currentPRLabel: UILabel!


override func viewDidLoad() {
    super.viewDidLoad()
    //Retrieve logged in user data and update the UI elements
    loadUserData()
    //Add the bottom button bar
    addBottomButtonBar()
}

func addBottomButtonBar() {
    let homeButton = UIButton(type: .system)
    homeButton.setTitle("Home", for: .normal)
    homeButton.addTarget(self, action: #selector(goToHome), for: .touchUpInside)
    let workoutButton = UIButton(type: .system)
    workoutButton.setTitle("Workout", for: .normal)
    workoutButton.addTarget(self, action: #selector(goToWorkout), for: .touchUpInside)
    let calendarButton = UIButton(type: .system)
    calendarButton.setTitle("Calendar", for: .normal)
    calendarButton.addTarget(self, action: #selector(goToCalendar), for: .touchUpInside)
    let profileButton = UIButton(type: .system)
    profileButton.setTitle("My Profile", for: .normal)
    profileButton.addTarget(self, action: #selector(goToProfile), for: .touchUpInside)
    
    let stackView = UIStackView(arrangedSubviews: [homeButton, workoutButton, calendarButton, profileButton])
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    view.addSubview(stackView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

//Add functions that navigate to the corresponding view controllers
@objc func goToHome() {
    //Navigate to the home view controller
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(homeVC, animated: true)
}

@objc func goToWorkout() {
    //Navigate to the workout view controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let workoutVC = storyboard.instantiateViewController(withIdentifier: "WorkoutViewController") as! WorkoutViewController
        self.navigationController?.pushViewController(workoutVC, animated: true)
}

@objc func goToCalendar() {
    //Navigate to the calendar view controller
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let calendarVC = storyboard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
        self.navigationController?.pushViewController(calendarVC, animated: true)
}

@objc func goToProfile() {
    //Navigate to the profile view controller
}

func loadUserData() {
    //Retrieve the logged in user's data from Core Data and update the UI elements{
    guard let loggedInUser = getLoggedInUser() else { return }
    
    nameLabel.text = loggedInUser.name
    experienceLevelLabel.text = loggedInUser.experienceLevel
    weightLabel.text = "\(loggedInUser.weight) lbs"
    currentPRLabel.text = "\(loggedInUser.currentPR) lbs"
    
    if let imageData = loggedInUser.profilePicture {
        profileImageView.image = UIImage(data: imageData)
    }
}


//IBAction for Edit button to present the EditProfileViewController
@IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
    let editProfileViewController = EditProfileViewController()
    navigationController?.pushViewController(editProfileViewController, animated: true)
}

}
