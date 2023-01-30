// Screen for editing the user's profile.


import UIKit
import CoreData

class EditProfileViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var experienceLevelField: UITextField!
    @IBOutlet weak var currentWeightField: UITextField!
    @IBOutlet weak var currentPRField: UITextField!
    var loggedInUser: User?
    let experienceLevels = ["Beginner", "Moderate", "Veteran", "JIMrat"]
    let experienceLevelPicker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        experienceLevelPicker.delegate = self
        experienceLevelPicker.dataSource = self
        experienceLevelField.inputView = experienceLevelPicker
        experienceLevelField.text = experienceLevels[0]
        if let user = loggedInUser {
            experienceLevelField.text = user.experienceLevel
            currentWeightField.text = user.currentWeight
            currentPRField.text = user.currentPR
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return experienceLevels.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return experienceLevels[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        experienceLevelField.text = experienceLevels[row]
    }
    
     @objc func textFieldDidChange(_ textField: UITextField) {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: textField.text!)
        if !allowedCharacters.isSuperset(of: characterSet) {
            textField.text = String(textField.text?.digits ?? "")
        }
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        if let user = loggedInUser {
            user.experienceLevel = experienceLevelField.text
            user.currentWeight = currentWeightField.text
            user.currentPR = currentPRField.text
        }
        
        do {
            try managedContext.save()
            navigationController?.popViewController(animated: true)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
