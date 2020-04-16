//
//  CrossCheckViewController.swift
//  CovidTracker
//
//  Created by Rachit Anurag on 2020/04/11.
//  Copyright © 2020 Rachit Anurag. All rights reserved.
//

import UIKit

class CrossCheckViewController: UIViewController {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    let headerView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
        view.backgroundColor = UIColor(rgb: 0xEEEEEE)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let introductionLabel: UILabel = {
        let view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 200, height: 25)
        view.text = "Introduction"
        view.textAlignment = .left
        view.textColor = .black
        view.font = UIFont(name: "FiraSans-Light", size: 16)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let progressView: UIProgressView = {
        let view = UIProgressView()
        view.frame = CGRect(x: 0, y: 0, width: 70, height: 20)
        view.progress = 0.23
        view.progressTintColor = UIColor(rgb: 0x49D581)
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let questionnaireHeading: UILabel = {
        let view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 350, height: 40)
        view.text = "Travel based cross-check check for COVID19"
        view.textAlignment = .center
        view.textColor = UIColor(rgb: 0x1C1C1C)
        view.font = UIFont(name: "FiraSans-Medium", size: 18)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let travelQuestionnaireCheckIcon: UIImageView = {
        let view = UIImageView()
        view.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        view.image = UIImage(named: "travelquestionnaireicon")
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let startQuestionnaireButton: UIButton = {
        let view = UIButton()
        view.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        view.layer.cornerRadius =  8.0
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor(rgb: 0x49D581).cgColor
        view.setTitleColor(.black, for: .normal)
        view.titleLabel?.textAlignment = .center
        view.setTitle("Start the questionnaire", for: .normal)
        view.titleLabel?.font = UIFont(name: "FiraSans-Thin", size: 16.0)
        view.backgroundColor = UIColor(rgb: 0xF6F6F6)
        view.addTarget(self, action: #selector(startQuestionnairePressed(sender:)), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let intersectionCalculatorHeading: UILabel = {
        let view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 350, height: 40)
        view.text = "Know if you've met a COVID+ve person"
        view.textAlignment = .center
        view.textColor = UIColor(rgb: 0x1C1C1C)
        view.font = UIFont(name: "FiraSans-Medium", size: 18)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let intersectionCalculatorCheckIcon: UIImageView = {
        let view = UIImageView()
        view.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        view.image = UIImage(named: "intersectioncalculatoricon")
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let startintersectionCalculatorButton: UIButton = {
        let view = UIButton()
        view.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        view.layer.cornerRadius =  8.0
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor(rgb: 0x49D581).cgColor
        view.setTitleColor(.black, for: .normal)
        view.titleLabel?.textAlignment = .center
        view.setTitle("Open intersection calculator", for: .normal)
        view.titleLabel?.font = UIFont(name: "FiraSans-Thin", size: 16.0)
        view.backgroundColor = UIColor(rgb: 0xF6F6F6)
        view.addTarget(self, action: #selector(startIntersectionCalculationIsPressed(sender:)), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let middleSeparator: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 2)
        view.backgroundColor = UIColor(rgb: 0xD2D2D2)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let endSeparator: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 2)
        view.backgroundColor = UIColor(rgb: 0xD2D2D2)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 70)
        view.backgroundColor = .clear
        let lineView = UIView()
        lineView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 2)
        lineView.backgroundColor = UIColor(rgb: 0xD2D2D2)
        view.addSubview(lineView)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nextButton: UIButton = {
        let view = UIButton()
        view.frame =  CGRect(x: 0, y: 0, width: 100, height: 40)
        view.layer.cornerRadius = 4.0
        view.backgroundColor = UIColor(rgb: 0xE03D51)
        view.titleLabel?.textAlignment = .center
        view.setTitle("Next", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(nextButtonIsTapped(sender:)), for: .touchUpInside)
        return view
    }()
    
    let backButton: UIButton = {
        let view = UIButton()
        view.frame =  CGRect(x: 0, y: 0, width: 100, height: 40)
        view.titleLabel?.textAlignment = .center
        view.setTitle("< Back", for: .normal)
        view.setTitleColor(UIColor(rgb: 0x3B24B1), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(backButtonIsTapped(sender:)), for: .touchUpInside)
        return view
    }()
    
    let bodyBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var navView: UIView?
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        navView = createNavView()
        if let nav = navView, let menuButton = nav.subviews.first(where: {$0 is UIButton}) as? UIButton {
            menuButton.addTarget(self, action: #selector(sideMenuPressed(sender:)), for: .touchUpInside)
            view.addSubview(nav)
        }
        addViews()
        placeViews()
        
        addIntoBodyView()
        placeBodyViews()
        
        nextButton.isHidden = true
        backButton.isHidden = true
        introductionLabel.text = "Patient"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func addViews() {
        headerView.addSubview(introductionLabel)
        headerView.addSubview(progressView)
        view.addSubview(headerView)
        bottomView.addSubview(nextButton)
        bottomView.addSubview(backButton)
        view.addSubview(bottomView)
        view.addSubview(bodyBaseView)
        
    }
    
    private func placeViews() {
        if let nav = navView {
            headerView.topAnchor.constraint(equalTo: nav.bottomAnchor, constant: 0).isActive = true
        } else {
            headerView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 60).isActive = true
        }
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        introductionLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 12).isActive = true
        introductionLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 30).isActive = true
        introductionLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        introductionLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        progressView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 23).isActive = true
        progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        progressView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        progressView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        
        bottomView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        nextButton.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        backButton.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
        backButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        bodyBaseView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        bodyBaseView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bodyBaseView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bodyBaseView.bottomAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
    }
    
    func addIntoBodyView() {
        bodyBaseView.addSubview(questionnaireHeading)
        bodyBaseView.addSubview(travelQuestionnaireCheckIcon)
        bodyBaseView.addSubview(startQuestionnaireButton)
        bodyBaseView.addSubview(middleSeparator)
        bodyBaseView.addSubview(intersectionCalculatorHeading)
        bodyBaseView.addSubview(intersectionCalculatorCheckIcon)
        bodyBaseView.addSubview(startintersectionCalculatorButton)
        bodyBaseView.addSubview(endSeparator)
    }
    
    func placeBodyViews() {
        questionnaireHeading.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 30).isActive = true
        questionnaireHeading.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        questionnaireHeading.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        questionnaireHeading.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        travelQuestionnaireCheckIcon.topAnchor.constraint(equalTo: questionnaireHeading.bottomAnchor, constant: 5).isActive = true
        travelQuestionnaireCheckIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        travelQuestionnaireCheckIcon.widthAnchor.constraint(equalToConstant: 200).isActive = true
        travelQuestionnaireCheckIcon.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        startQuestionnaireButton.topAnchor.constraint(equalTo: travelQuestionnaireCheckIcon.bottomAnchor, constant: 10).isActive = true
        startQuestionnaireButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startQuestionnaireButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        startQuestionnaireButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        middleSeparator.topAnchor.constraint(equalTo: startQuestionnaireButton.bottomAnchor, constant: 10).isActive = true
        middleSeparator.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        middleSeparator.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        middleSeparator.heightAnchor.constraint(equalToConstant: 3).isActive = true
        
        intersectionCalculatorHeading.topAnchor.constraint(equalTo: middleSeparator.bottomAnchor, constant: 50).isActive = true
        intersectionCalculatorHeading.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        intersectionCalculatorHeading.widthAnchor.constraint(equalToConstant: 350).isActive = true
        intersectionCalculatorHeading.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        intersectionCalculatorCheckIcon.topAnchor.constraint(equalTo: intersectionCalculatorHeading.bottomAnchor, constant: 5).isActive = true
        intersectionCalculatorCheckIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        intersectionCalculatorCheckIcon.widthAnchor.constraint(equalToConstant: 200).isActive = true
        intersectionCalculatorCheckIcon.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        startintersectionCalculatorButton.topAnchor.constraint(equalTo: intersectionCalculatorCheckIcon.bottomAnchor, constant: 10).isActive = true
        startintersectionCalculatorButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startintersectionCalculatorButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        startintersectionCalculatorButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        endSeparator.topAnchor.constraint(equalTo: startintersectionCalculatorButton.bottomAnchor, constant: 10).isActive = true
        endSeparator.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        endSeparator.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        endSeparator.heightAnchor.constraint(equalToConstant: 3).isActive = true
    }
    
    @objc func sideMenuPressed(sender: UIButton) {
        print("Side menu pressed.")
    }
    
    @objc func nextButtonIsTapped(sender: UIButton) {
        print("Next button is pressed.")
        
    }
    
    @objc func backButtonIsTapped(sender: UIButton) {
        print("Back button is pressed.")
    }
    
    @objc func startQuestionnairePressed(sender: UIButton) {
        print("Questionnaire button is pressed.")
    }
    
    @objc func startIntersectionCalculationIsPressed(sender: UIButton) {
        print("Intersection calculator is pressed.")
        let vc = LocationHistoryViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

/*
import UIKit

class CrossCheckViewController: UIViewController {
    
    let nameField: UITextField = {
        let view = UITextField()
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 100, height: 50)
        view.layer.cornerRadius = 5.0
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1.0
        view.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        view.autocorrectionType = .no
        view.backgroundColor = UIColor(red: 239, green: 239, blue: 239)
        view.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: view.frame.height))
        view.leftViewMode = .always
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let statusField: UITextField = {
        let view = UITextField()
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 100, height: 50)
        view.layer.cornerRadius = 5.0
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1.0
        view.attributedPlaceholder = NSAttributedString(string: "Status", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        view.autocorrectionType = .no
        view.backgroundColor = UIColor(red: 239, green: 239, blue: 239)
        view.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: view.frame.height))
        view.keyboardType = .numberPad
        view.leftViewMode = .always
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let latitudeField: UITextField = {
        let view = UITextField()
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 100, height: 50)
        view.layer.cornerRadius = 5.0
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1.0
        view.attributedPlaceholder = NSAttributedString(string: "Latitude", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        view.autocorrectionType = .no
        view.backgroundColor = UIColor(red: 239, green: 239, blue: 239)
        view.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: view.frame.height))
        view.keyboardType = .decimalPad
        view.leftViewMode = .always
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let longitudeField: UITextField = {
        let view = UITextField()
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 100, height: 50)
        view.layer.cornerRadius = 5.0
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1.0
        view.attributedPlaceholder = NSAttributedString(string: "Logitude", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        view.autocorrectionType = .no
        view.backgroundColor = UIColor(red: 239, green: 239, blue: 239)
        view.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: view.frame.height))
        view.keyboardType = .decimalPad
        view.leftViewMode = .always
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let postButton: UIButton = {
        let view = UIButton()
        view.frame = CGRect(x: 0, y: 0, width: 150, height: 40)
        view.layer.cornerRadius = 10.0
        view.backgroundColor = UIColor(red: 231, green: 46, blue: 104)
        view.setTitle("POST", for: .normal)
        view.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 20.0)
        view.titleLabel?.textAlignment = .center
        view.addTarget(self, action: #selector(postButtonIsPressed(sender:)), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .orange
        
        let navView = createNavView()
        if let menuButton = navView.subviews.first(where: {$0 is UIButton}) as? UIButton {
            menuButton.addTarget(self, action: #selector(sideMenuPressed(sender:)), for: .touchUpInside)
        }
        view.addSubview(navView)
        
        addViews()
        placeViews()
    }
    
    private func addViews() {
        view.addSubview(nameField)
        view.addSubview(statusField)
        view.addSubview(latitudeField)
        view.addSubview(longitudeField)
        view.addSubview(postButton)
    }
    
    private func placeViews() {
        nameField.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 50).isActive = true
        nameField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20).isActive = true
        nameField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20).isActive = true
        nameField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        statusField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20).isActive = true
        statusField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor).isActive = true
        statusField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor).isActive = true
        statusField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        latitudeField.topAnchor.constraint(equalTo: statusField.bottomAnchor, constant: 20).isActive = true
        latitudeField.leadingAnchor.constraint(equalTo: statusField.leadingAnchor).isActive = true
        latitudeField.trailingAnchor.constraint(equalTo: statusField.trailingAnchor).isActive = true
        latitudeField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        longitudeField.topAnchor.constraint(equalTo: latitudeField.bottomAnchor, constant: 20).isActive = true
        longitudeField.leadingAnchor.constraint(equalTo: latitudeField.leadingAnchor).isActive = true
        longitudeField.trailingAnchor.constraint(equalTo: latitudeField.trailingAnchor).isActive = true
        longitudeField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        postButton.topAnchor.constraint(equalTo: longitudeField.bottomAnchor, constant: 40).isActive = true
        postButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        postButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        postButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    @objc func sideMenuPressed(sender: UIButton) {
        print("Side menu pressed.")
    }
    
    @objc func postButtonIsPressed(sender: UIButton) {
        guard let name = nameField.text?.count == 0 ? UUID().uuidString : nameField.text else {
            print("Name not found.")
            return
        }
        guard let latitude = latitudeField.text?.count == 0 ? "35.689487" : latitudeField.text else {
            print("Latitude not found.")
            return
        }
        guard let longitude = longitudeField.text?.count == 0 ? "139.691711" : longitudeField.text else {
            print("Longitude not found.")
            return
        }
        let inputData: [String : Any] = ["name": name, "status": 0, "latitude": latitude, "longitude": longitude]
        Service.shared.sendData(inputData: inputData)
    }
}
*/