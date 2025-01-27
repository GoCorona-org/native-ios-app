//
//  PatientSymptomCheckViewController.swift
//  CovidTracker
//
//  Created by Rachit Anurag on 2020/04/12.
//  Copyright © 2020 Rachit Anurag. All rights reserved.
//

import UIKit

class PatientSymptomCheckViewController: CheckupViewController {
    
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
        view.contentSize = CGSize(width: UIScreen.main.bounds.width, height: finalHeight + 300)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    let symptomCheckHeading: UILabel = {
        let view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 350, height: 40)
        view.text = "Please check all the statements below that apply to you"
        view.textAlignment = .left
        view.numberOfLines = 2
        view.lineBreakMode = .byWordWrapping
        view.textColor = UIColor(rgb: 0x1C1C1C)
        view.font = UIFont(name: "FiraSans-Medium", size: 20)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let instructionHeading: UILabel = {
        let view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 350, height: 20)
        view.text = "Select one in each row"
        view.textAlignment = .left
        view.textColor = UIColor(rgb: 0x1C1C1C)
        view.font = UIFont(name: "FiraSans-Light", size: 16)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let firstSectionHeading: UILabel = {
        let view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 350, height: 20)
        view.text = "Do you have or have had a health history?"
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
    
    let firstTableCellId = "symptomCellID"
    
    let secondSectionHeading: UILabel = {
        let view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 350, height: 20)
        view.text = "Do you smoke cigarettes?"
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
    
    let secondTableCellId = "smokingCellID"
    
    let thirdSectionHeading: UILabel = {
        let view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 350, height: 20)
        view.text = "Do you have low immunity due to organ transplant or HIV?"
        view.numberOfLines = 2
        view.lineBreakMode = .byWordWrapping
        view.textAlignment = .left
        view.textColor = UIColor(rgb: 0x1C1C1C)
        view.font = UIFont(name: "FiraSans-Light", size: 16)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let thirdSectionTableView: UITableView = {
        let view = UITableView()
        view.frame = CGRect(x: 0, y: 0, width: 300, height: 400)
        view.tag = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let thirdTableCellId = "lowImmunityCellID"
    
    let healthHistorySymptoms = ["Asthma", "High BP", "Kidney disease", "Heart disease", "Lung disease", "Stroke", "Diabetes", "No, I do not have any of the above health issues"]
    
    private var selectedHealthCondition = ""
    private var selectedTransplantOrHIV = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.isHidden = false
        nextButton.isHidden = false
        introductionLabel.text = "Patient"
        
        
        firstSectionTableView.register(SymptomTableViewCell.self, forCellReuseIdentifier: firstTableCellId)
        firstSectionTableView.delegate = self
        firstSectionTableView.dataSource = self
        
        secondSectionTableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: secondTableCellId)
        secondSectionTableView.delegate = self
        secondSectionTableView.dataSource = self
        
        thirdSectionTableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: thirdTableCellId)
        thirdSectionTableView.delegate = self
        thirdSectionTableView.dataSource = self
    }
    
    override func addIntoBodyView() {
        scrollView.addSubview(symptomCheckHeading)
        scrollView.addSubview(instructionHeading)
        scrollView.addSubview(firstSectionHeading)
        scrollView.addSubview(firstSectionTableView)
        
        scrollView.addSubview(secondSectionHeading)
        scrollView.addSubview(secondSectionTableView)
        
        scrollView.addSubview(thirdSectionHeading)
        scrollView.addSubview(thirdSectionTableView)
        
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
        
        instructionHeading.topAnchor.constraint(equalTo: symptomCheckHeading.bottomAnchor, constant: 20).isActive = true
        instructionHeading.leadingAnchor.constraint(equalTo: symptomCheckHeading.leadingAnchor).isActive = true
        instructionHeading.widthAnchor.constraint(equalToConstant: 350).isActive = true
        instructionHeading.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        firstSectionHeading.topAnchor.constraint(equalTo: instructionHeading.bottomAnchor, constant: 20).isActive = true
        firstSectionHeading.leadingAnchor.constraint(equalTo: symptomCheckHeading.leadingAnchor).isActive = true
        firstSectionHeading.widthAnchor.constraint(equalToConstant: 350).isActive = true
        firstSectionHeading.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        firstSectionTableView.topAnchor.constraint(equalTo: firstSectionHeading.bottomAnchor).isActive = true
        firstSectionTableView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        firstSectionTableView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        firstSectionTableView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        secondSectionHeading.topAnchor.constraint(equalTo: firstSectionTableView.bottomAnchor, constant: 20).isActive = true
        secondSectionHeading.leadingAnchor.constraint(equalTo: symptomCheckHeading.leadingAnchor).isActive = true
        secondSectionHeading.widthAnchor.constraint(equalToConstant: 350).isActive = true
        secondSectionHeading.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        secondSectionTableView.topAnchor.constraint(equalTo: secondSectionHeading.bottomAnchor).isActive = true
        secondSectionTableView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        secondSectionTableView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        secondSectionTableView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        thirdSectionHeading.topAnchor.constraint(equalTo: secondSectionTableView.bottomAnchor, constant: 20).isActive = true
        thirdSectionHeading.leadingAnchor.constraint(equalTo: symptomCheckHeading.leadingAnchor).isActive = true
        thirdSectionHeading.widthAnchor.constraint(equalToConstant: 350).isActive = true
        thirdSectionHeading.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        thirdSectionTableView.topAnchor.constraint(equalTo: thirdSectionHeading.bottomAnchor).isActive = true
        thirdSectionTableView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        thirdSectionTableView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        thirdSectionTableView.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    override func backButtonIsTapped(sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func nextButtonIsTapped(sender: UIButton) {
        print("Symptom check page's next button is tapped.")
        collectData()
        let vc = PatientSCTwoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func collectData() {
        medicalData.transplant = selectedTransplantOrHIV
        medicalData.hiv = selectedTransplantOrHIV
        if selectedHealthCondition.contains("Diabetes") {
            medicalData.diabetes = true
        } else if selectedHealthCondition.contains("Kidney") {
            medicalData.kidney = true
        } else if selectedHealthCondition.contains("Heart") {
            medicalData.heart = true
        } else if selectedHealthCondition.contains("Lung") {
            medicalData.lungs = true
        } else if selectedHealthCondition.contains("High BP") {
            medicalData.hypertension = true
        } else if selectedHealthCondition.contains("Stroke") {
            medicalData.stroke = true
        }
    }
}
extension PatientSymptomCheckViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 0 {
            return healthHistorySymptoms.count
        } else {
            return options.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 0, let cell = tableView.dequeueReusableCell(withIdentifier: firstTableCellId, for: indexPath) as? SymptomTableViewCell {
            cell.textLabel?.text = healthHistorySymptoms[indexPath.item]
            return cell
        } else if tableView.tag == 1, let cell = tableView.dequeueReusableCell(withIdentifier: secondTableCellId, for: indexPath) as? OptionsTableViewCell {
            cell.textLabel?.text = options[indexPath.item]
            return cell
        } else if tableView.tag == 2, let cell = tableView.dequeueReusableCell(withIdentifier: thirdTableCellId, for: indexPath) as? OptionsTableViewCell {
            cell.textLabel?.text = options[indexPath.item]
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(healthHistorySymptoms[indexPath.item])
        if tableView.tag == 0 {
            selectedHealthCondition = healthHistorySymptoms[indexPath.item]
        } else if tableView.tag == 2 {
            if options[indexPath.item] == "Yes" {
                selectedTransplantOrHIV = true
            } else {
                selectedTransplantOrHIV = false
            }
        }
    }
}
