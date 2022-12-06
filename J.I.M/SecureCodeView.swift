//
//  SecureCodeView.swift
//  J.I.M
//
//  Created by Julian Manaois on 12/06/22.
//

import UIKit

//-----------------------------------------------------------------------------------------------------------------------------------------------
class SecureCodeView: UIViewController {

	@IBOutlet var labelTitle: UILabel!
	@IBOutlet var labelSubTitle: UILabel!
	@IBOutlet var textFieldSecureCode: UITextField!
	@IBOutlet var labelAvailableTime: UILabel!

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func viewDidLoad() {

		super.viewDidLoad()

		navigationItem.titleView = UIImageView(image: UIImage(systemName: "circles.hexagongrid.fill"))
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(actionDone))

		loadData()
	}

	// MARK: - Data methods
	//-------------------------------------------------------------------------------------------------------------------------------------------
	func loadData() {

		labelTitle.text = "Enter secure\ncode to verify"
		labelSubTitle.text = "Please enter your verification code for verify your mobile number."
		textFieldSecureCode.text = "8890128"
		labelAvailableTime.text = "Available in 9 seconds"
	}

	// MARK: - User actions
	//-------------------------------------------------------------------------------------------------------------------------------------------
	@objc func actionDone() {

		print(#function)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionResendCode(_ sender: Any) {

		print(#function)
	}
}