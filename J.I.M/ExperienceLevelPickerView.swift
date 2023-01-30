// Class for the scroll menu when selecting gym experience level.


import UIKit

class ExperienceLevelPickerView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    let options = ["Beginner", "Moderate", "Veteran", "JIMrat"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }
}
