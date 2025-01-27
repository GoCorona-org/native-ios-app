//
//  QuarantineViewController.swift
//  CovidTracker
//
//  Created by Rachit Anurag on 2020/04/11.
//  Copyright © 2020 Rachit Anurag. All rights reserved.
//

import UIKit

class QuarantineViewController: UIViewController{
    
    var collectionView: UICollectionView!
    var cellId = "Cell"
    let numberOfPastMonths: Int = 12
    let numberOfFutureMonths: Int = 12
    let cellHeight: Int = 55
    let headerHeight: Int = 50
    
    let calendar = Calendar.init(identifier: .gregorian)
    
    var selectedDate: Date?
    var firstTimeRunning = true
    
    var firstTimeDateSeleted = true
    
    
    var endDate = Date()
    var startDate = Date()
    var shoppingDateAdded = Date()
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    let calendarView: UIView = {
        let view = UIView()
        var finalHeight: CGFloat = 0.0
        if let size = bodySize  {
            finalHeight = size.height
        } else {
            finalHeight = 550
        }
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 40, height: finalHeight + 100)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let headerView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 70)
        view.backgroundColor = .clear
        let lineView = UIView()
        lineView.frame = CGRect(x: 0, y: 58, width: UIScreen.main.bounds.width, height: 1)
        lineView.backgroundColor = UIColor(rgb: 0xD2D2D2)
        view.addSubview(lineView)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let myCalenderLabel: UILabel = {
        let view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 200, height: 25)
        view.text = "MY CALENDER"
        view.textAlignment = .center
        view.textColor = .black
        view.font = UIFont(name: "FiraSans-ExtraBold", size: 20)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let quarantineButton: UIButton = {
        let view = UIButton()
        view.frame =  CGRect(x: 0, y: 0, width: 102, height: 35)
        view.backgroundColor = UIColor(rgb: 0xFFB8C4)
        view.titleLabel?.textAlignment = .center
        view.setTitle("Quarantine", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.titleLabel?.font = UIFont(name: "FiraSans-Regular", size: 15)
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 0.7
        view.layer.borderColor = UIColor(rgb: 0x909090).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(quarantinePressed(sender:)), for: .touchUpInside)
        return view
    }()
    
    let shoppingDaysButton: UIButton = {
        let view = UIButton()
        view.frame =  CGRect(x: 0, y: 0, width: 128, height: 35)
        view.backgroundColor = UIColor(rgb: 0xA9E7CB)
        view.titleLabel?.textAlignment = .center
        view.setTitle("Shopping days", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.titleLabel?.font = UIFont(name: "FiraSans-Regular", size: 15)
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 0.7
        view.layer.borderColor = UIColor(rgb: 0x909090).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(shoppingDaysPressed(sender:)), for: .touchUpInside)
        return view
    }()
    
    let calenderEditButton: UIButton = {
        let view = UIButton()
        view.frame =  CGRect(x: 0, y: 0, width: 25, height: 25)
        view.setImage(UIImage(named: "calenderedit"), for: .normal)
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(calenderEditPressed(sender:)), for: .touchUpInside)
        return view
    }()
    
    let shoppingListButton: UIButton = {
        let view = UIButton()
        view.frame =  CGRect(x: 0, y: 0, width: 25, height: 25)
        view.setImage(UIImage(named: "shoppinglistselected"), for: .normal)
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(shoppingListPressed(sender:)), for: .touchUpInside)
        return view
    }()
    
    let bodyBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
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
    
    let doneButton: UIButton = {
        let view = UIButton()
        view.frame =  CGRect(x: 0, y: 0, width: 100, height: 40)
        view.layer.cornerRadius = 4.0
        view.backgroundColor = UIColor(rgb: 0xE03D51)
        view.titleLabel?.textAlignment = .center
        view.setTitle("DONE", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(doneButtonIsTapped(sender:)), for: .touchUpInside)
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
    
    func createCalenderView() {
        let layout: SeparatorCollectionViewFlowLayout = SeparatorCollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 1
        collectionView = UICollectionView(frame: calendarView.frame, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Register the header view
        collectionView.register(CalendarHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "calendarHeaderView")
        // Register the cell view
        collectionView.register(CalendarViewCell.self, forCellWithReuseIdentifier: "calendarCell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
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
        createCalenderView()

        addIntoBodyView()
        placeCalenderViews()
        
        quarantineButton.isEnabled = false
        shoppingDaysButton.isEnabled = false
        shoppingListButton.isEnabled = false
        
        calenderEditButton.setImage(UIImage(named: "calenderedit"), for: .normal)
        quarantineButton.backgroundColor = UIColor(rgb: 0xFFB8C4)
        shoppingDaysButton.backgroundColor = UIColor(rgb: 0xA9E7CB)
        shoppingListButton.setImage(UIImage(named: "shoppinglistselected"), for: .normal)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        bodySize = bodyBaseView.frame.size
        let today = Date()
        let year = calendar.component(.year, from: today)
        let month = calendar.component(.month, from: today)
        let day = calendar.component(.day, from: today)
        let dayOffset = self.dayOffset(year: year, month: month)

        
        if firstTimeRunning {
            collectionView.scrollToItem(at: IndexPath(item: day + dayOffset + 7, section: numberOfPastMonths), at: .centeredVertically, animated: false)
           
            firstTimeRunning = false
        }        
    }

    private func addViews() {
        
        headerView.addSubview(quarantineButton)
        headerView.addSubview(myCalenderLabel)
        headerView.addSubview(shoppingDaysButton)
        headerView.addSubview(calenderEditButton)
        headerView.addSubview(shoppingListButton)
        view.addSubview(headerView)
        view.addSubview(bodyBaseView)
        bottomView.addSubview(doneButton)
        bottomView.addSubview(backButton)
        view.addSubview(bottomView)
    }
    
    private func placeViews() {
        if let nav = navView {
            headerView.topAnchor.constraint(equalTo: nav.bottomAnchor, constant: 0).isActive = true
        } else {
            headerView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 60).isActive = true
        }
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        myCalenderLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 20).isActive = true
        myCalenderLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        myCalenderLabel.widthAnchor.constraint(equalToConstant: 220).isActive = true
        myCalenderLabel.heightAnchor.constraint(equalToConstant: 37).isActive = true
        
        calenderEditButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 17).isActive = true
        calenderEditButton.leadingAnchor.constraint(equalTo: myCalenderLabel.trailingAnchor, constant: -25).isActive = true
        calenderEditButton.widthAnchor.constraint(equalToConstant: 39).isActive = true
        calenderEditButton.heightAnchor.constraint(equalToConstant: 39).isActive = true
        
        quarantineButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 80).isActive = true
        quarantineButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor, constant: -80).isActive = true
        quarantineButton.widthAnchor.constraint(equalToConstant: 102).isActive = true
        quarantineButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        shoppingDaysButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 80).isActive = true
        shoppingDaysButton.leadingAnchor.constraint(equalTo: quarantineButton.trailingAnchor, constant: 5).isActive = true
        shoppingDaysButton.widthAnchor.constraint(equalToConstant: 128).isActive = true
        shoppingDaysButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
           
        shoppingListButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 80).isActive = true
        shoppingListButton.leadingAnchor.constraint(equalTo: shoppingDaysButton.trailingAnchor, constant: 5).isActive = true
        shoppingListButton.widthAnchor.constraint(equalToConstant: 33).isActive = true
        shoppingListButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        
        doneButton.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
        doneButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20).isActive = true
        doneButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        backButton.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
        backButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        bodyBaseView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        bodyBaseView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bodyBaseView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bodyBaseView.bottomAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
    }
    
    func addIntoBodyView() {
        calendarView.addSubview(collectionView)
        view.addSubview(calendarView)
        bottomView.isHidden = true
    }
    
    func placeCalenderViews() {
        
        calendarView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        calendarView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: calendarView.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: calendarView.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: calendarView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: calendarView.trailingAnchor).isActive = true
    }
    
    @objc func sideMenuPressed(sender: UIButton) {
        print("Side menu pressed.")
    }
    
    @objc func calenderEditPressed(sender: UIButton) {
        print("Calender edit pressed.")
        
        quarantineButton.isEnabled = true
        shoppingDaysButton.isEnabled = true
        shoppingListButton.isEnabled = true
        UserDefaults.standard.removeObject(forKey: "StartDate")
        UserDefaults.standard.removeObject(forKey: "EndDate")
        let selfQuarantineVC = SelfQuarantineViewController()
        self.navigationController?.pushViewController(selfQuarantineVC, animated: true)
    }
    
    @objc func quarantinePressed(sender: UIButton) {
        print("Quarantine pressed.")
    }
    
    @objc func shoppingDaysPressed(sender: UIButton) {
        print("Shopping days pressed.")
    }
    
    @objc func shoppingListPressed(sender: UIButton) {
        print("Shopping list pressed.")
    }
    
    @objc func doneButtonIsTapped(sender: UIButton) {
        print("Next button is pressed.")
        let qurantineVC = QuarantineViewController()
        self.navigationController?.pushViewController(qurantineVC, animated: false)
    }
    
    @objc func backButtonIsTapped(sender: UIButton) {
        print("Back button is pressed.")
        self.navigationController?.popViewController(animated: true)
    }
}
