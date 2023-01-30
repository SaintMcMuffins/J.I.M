//
//  SignUp1View.swift
//  J.I.M
//
//  Created by Julian Manaois on 12/6/22.
//

import UIKit

//-----------------------------------------------------------------------------------------------------------------------------------------------
class SignUp1View: UIViewController {

	@IBOutlet var textFieldFirstName: UITextField!
	@IBOutlet var textFieldLastName: UITextField!
	@IBOutlet var textFieldEmail: UITextField!
	@IBOutlet var textFieldPassword: UITextField!
	@IBOutlet var textFieldPassword2: UITextField!

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func viewDidLoad() {

		super.viewDidLoad()

		navigationController?.navigationBar.prefersLargeTitles = false
		navigationItem.largeTitleDisplayMode = .never

		navigationItem.titleView = UIImageView(image: UIImage(systemName: "circles.hexagongrid.fill"))

		textFieldFirstName.setLeftPadding(value: 15)
		textFieldLastName.setLeftPadding(value: 15)
		textFieldEmail.setLeftPadding(value: 15)
		textFieldPassword.setLeftPadding(value: 15)
		textFieldPassword2.setLeftPadding(value: 15)
	}

	// MARK: - User actions
	//-------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionFacebook(_ sender: Any) {

		print(#function)
		dismiss(animated: true)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionContinue(_ sender: Any) {

		print(#function)
		dismiss(animated: true)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionTerms(_ sender: Any) {

		print(#function)
		dismiss(animated: true)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionPrivacy(_ sender: Any) {

		print(#function)
		dismiss(animated: true)
	}
}
