//
//  PatientSCThreeViewController.swift
//  CovidTracker
//
//  Created by Rachit Anurag on 2020/04/16.
//  Copyright © 2020 Rachit Anurag. All rights reserved.
//

import UIKit

class PatientSCThreeViewController: CheckupViewController {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        var finalHeight: CGFloat = 0.0
        if let size = bodySize  {
            finalHeight = size.height
        } else {
            finalHeight = 700.0
        }
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: finalHeight)
        view.contentSize = CGSize(width: UIScreen.main.bounds.width, height: finalHeight + 200)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    let symptomCheckHeading: UILabel = {
        let view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 350, height: 40)
        view.text = "Please tell us about your symptoms"
        view.textAlignment = .left
        view.numberOfLines = 2
        view.lineBreakMode = .byWordWrapping
        view.textColor = UIColor(rgb: 0x1C1C1C)
        view.font = UIFont(name: "FiraSans-Medium", size: 20)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let pageicon: UIImageView = {
        let view = UIImageView()
        view.frame = CGRect(x: 0, y: 0, width: 250, height: 230)
        view.image = UIImage(named: "patientscthreecheck")
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let firstSectionHeading: UILabel = {
        let view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 350, height: 20)
        view.text = "Do you have cough?"
        view.textAlignment = .left
        view.textColor = UIColor(rgb: 0x1C1C1C)
        view.font = UIFont(name: "FiraSans-Light", size: 16)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let firstSectionTableView: UITableView = {
        let view = UITableView()
        view.frame = CGRect(x: 0, y: 0, width: 300, height: 400)
        view.tag = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let firstTableCellId = "coughCellID"
    
    let firstOptions = ["Yes/Maybe", "No"]
    
    let secondSectionHeading: UILabel = {
        let view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 350, height: 20)
        view.text = "If yes, then check the following"
        view.textAlignment = .left
        view.textColor = UIColor(rgb: 0x1C1C1C)
        view.font = UIFont(name: "FiraSans-Light", size: 16)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let secondSectionTableView: UITableView = {
        let view = UITableView()
        view.frame = CGRect(x: 0, y: 0, width: 300, height: 400)
        view.tag = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let secondTableCellId = "coughDescriptionCellID"
    
    let coughDescriptions = ["Dry cough", "Cough with sputum", "Cough with chest pain", "Cough with abdominal pain", "Cough with blood in it"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.isHidden = false
        nextButton.isHidden = false
        introductionLabel.text = "Patient"
        
        firstSectionTableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: firstTableCellId)
        firstSectionTableView.delegate = self
        firstSectionTableView.dataSource = self
        
        secondSectionTableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: secondTableCellId)
        secondSectionTableView.delegate = self
        secondSectionTableView.dataSource = self
    }
    
    override func addIntoBodyView() {
        scrollView.addSubview(symptomCheckHeading)
        scrollView.addSubview(pageicon)
        
        scrollView.addSubview(firstSectionHeading)
        scrollView.addSubview(firstSectionTableView)
        
        scrollView.addSubview(secondSectionHeading)
        scrollView.addSubview(secondSectionTableView)
        
        bodyBaseView.addSubview(scrollView)
    }
    
    override func placeBodyViews() {
        
        scrollView.topAnchor.constraint(equalTo: bodyBaseView.topAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: bodyBaseView.widthAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: bodyBaseView.leadingAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: bodyBaseView.heightAnchor).isActive = true
        
        
        symptomCheckHeading.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        symptomCheckHeading.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30).isActive = true
        symptomCheckHeading.widthAnchor.constraint(equalToConstant: 350).isActive = true
        symptomCheckHeading.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        pageicon.topAnchor.constraint(equalTo: symptomCheckHeading.bottomAnchor, constant: 20).isActive = true
        pageicon.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        pageicon.widthAnchor.constraint(equalToConstant: 220).isActive = true
        pageicon.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        firstSectionHeading.topAnchor.constraint(equalTo: pageicon.bottomAnchor, constant: 20).isActive = true
        firstSectionHeading.leadingAnchor.constraint(equalTo: symptomCheckHeading.leadingAnchor).isActive = true
        firstSectionHeading.widthAnchor.constraint(equalToConstant: 350).isActive = true
        firstSectionHeading.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        firstSectionTableView.topAnchor.constraint(equalTo: firstSectionHeading.bottomAnchor).isActive = true
        firstSectionTableView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        firstSectionTableView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        firstSectionTableView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        secondSectionHeading.topAnchor.constraint(equalTo: firstSectionTableView.bottomAnchor, constant: 20).isActive = true
        secondSectionHeading.leadingAnchor.constraint(equalTo: symptomCheckHeading.leadingAnchor).isActive = true
        secondSectionHeading.widthAnchor.constraint(equalToConstant: 350).isActive = true
        secondSectionHeading.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        secondSectionTableView.topAnchor.constraint(equalTo: secondSectionHeading.bottomAnchor).isActive = true
        secondSectionTableView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        secondSectionTableView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        secondSectionTableView.heightAnchor.constraint(equalToConstant: 175).isActive = true
    }
    
    override func backButtonIsTapped(sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func nextButtonIsTapped(sender: UIButton) {
        print("Next button is tapped in PatientSCThreeVC.")
        let vc = PatientSCFourViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension PatientSCThreeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 0 {
            return firstOptions.count
        } else if tableView.tag == 1 {
            return coughDescriptions.count
        } else {
            return options.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 0, let cell = tableView.dequeueReusableCell(withIdentifier: firstTableCellId, for: indexPath) as? OptionsTableViewCell {
            cell.textLabel?.text = firstOptions[indexPath.item]
            return cell
        } else if tableView.tag == 1, let cell = tableView.dequeueReusableCell(withIdentifier: secondTableCellId, for: indexPath) as? OptionsTableViewCell {
            cell.textLabel?.text = coughDescriptions[indexPath.item]
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.tag == 0 && firstOptions[indexPath.item] == "No" {
            medicalData.cough = 0
        } else if tableView.tag == 1 {
            if coughDescriptions[indexPath.item].contains("Dry Cough") {
                medicalData.cough = 1
            } else if coughDescriptions[indexPath.item].contains("sputum") {
                medicalData.cough = 2
            } else if coughDescriptions[indexPath.item].contains("chest pain") {
                medicalData.cough = 3
            } else if coughDescriptions[indexPath.item].contains("abdominal pain") {
                medicalData.cough = 4
            }
        }
    }
}
