//
//  LocationHistoryViewController.swift
//  CovidTracker
//
//  Created by Rachit Anurag on 2020/04/13.
//  Copyright © 2020 Rachit Anurag. All rights reserved.
//

import UIKit
import SafariServices
import NVActivityIndicatorView

class LocationHistoryViewController: CrossCheckViewController, SFSafariViewControllerDelegate, DocumentDelegate {
    
    var documentPicker: DocumentPicker!
    
    let tutorialHeading: UILabel = {
        let view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 350, height: 40)
        view.text = "Run the tutorial and download the data"
        view.textAlignment = .center
        view.textColor = UIColor(rgb: 0x1C1C1C)
        view.font = UIFont(name: "FiraSans-Medium", size: 18)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tutorialButton: UIButton = {
        let view = UIButton()
        view.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        view.layer.cornerRadius =  8.0
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor(rgb: 0x49D581).cgColor
        view.setTitleColor(.black, for: .normal)
        view.contentHorizontalAlignment = .left
        view.setImage(UIImage(named: "questionmarkicon"), for: .normal)
        view.setTitle("Take me through the tutorial", for: .normal)
        view.titleLabel?.font = UIFont(name: "FiraSans-Thin", size: 16.0)
        view.imageEdgeInsets = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 0)
        view.titleEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        view.backgroundColor = UIColor(rgb: 0xF6F6F6)
        view.addTarget(self, action: #selector(startTutorialButtonIsPressed(sender:)), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let googleDownloadButton: UIButton = {
        let view = UIButton()
        view.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        view.layer.cornerRadius =  8.0
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor(rgb: 0x49D581).cgColor
        view.setTitleColor(.black, for: .normal)
        view.contentHorizontalAlignment = .left
        view.setImage(UIImage(named: "linkicon"), for: .normal)
        view.setTitle("I'm all set, take me Google downloads", for: .normal)
        view.titleLabel?.font = UIFont(name: "FiraSans-Thin", size: 16.0)
        view.titleLabel?.adjustsFontSizeToFitWidth = true
        view.imageEdgeInsets = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 0)
        view.titleEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        view.backgroundColor = UIColor(rgb: 0xF6F6F6)
        view.addTarget(self, action: #selector(startGoogleTakeoutIsPressed(sender:)), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let uploadHeading: UILabel = {
        let view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 350, height: 40)
        view.text = "Upload the Google takeout ZIP file"
        view.textAlignment = .center
        view.textColor = UIColor(rgb: 0x1C1C1C)
        view.font = UIFont(name: "FiraSans-Medium", size: 18)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let uploadButton: UIButton = {
        let view = UIButton()
        view.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        view.layer.cornerRadius =  8.0
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor(rgb: 0x49D581).cgColor
        view.setTitleColor(.black, for: .normal)
        view.contentHorizontalAlignment = .left
        view.setImage(UIImage(named: "uploadicon"), for: .normal)
        view.setTitle("Upload here", for: .normal)
        view.titleLabel?.font = UIFont(name: "FiraSans-Thin", size: 16.0)
        view.titleLabel?.adjustsFontSizeToFitWidth = true
        view.imageEdgeInsets = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 0)
        view.titleEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        view.backgroundColor = UIColor(rgb: 0xF6F6F6)
        view.addTarget(self, action: #selector(uploadFileIsPressed(sender:)), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var activityIndicator: NVActivityIndicatorView = {
        let indicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 64, height: 64), type: .ballScaleMultiple, color: UIColor(rgb: 0xE72E68), padding: 0)
        indicator.isHidden = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    //Black overlay
    var indicatorOverlay: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        view.backgroundColor = .black
        view.alpha = 0.75
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        introductionLabel.text = "Patient"
        backButton.isHidden = false
        nextButton.isHidden = false
        nextButton.setTitle("Submit", for: .normal)
        
        documentPicker = DocumentPicker(presentationController: self, delegate: self)
        
        bodyBaseView.addSubview(indicatorOverlay)
        bodyBaseView.addSubview(activityIndicator)
        
        indicatorOverlay.centerXAnchor.constraint(equalTo: bodyBaseView.centerXAnchor).isActive = true
        indicatorOverlay.centerYAnchor.constraint(equalTo: bodyBaseView.centerYAnchor).isActive = true
        indicatorOverlay.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        indicatorOverlay.heightAnchor.constraint(equalToConstant: self.view.frame.height).isActive = true
        
        activityIndicator.centerXAnchor.constraint(equalTo: bodyBaseView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: bodyBaseView.centerYAnchor).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        /*activityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 20.0, execute: {
            self.activityIndicator.stopAnimating()
        })*/
    }
    
    override func addIntoBodyView() {
        bodyBaseView.addSubview(tutorialHeading)
        bodyBaseView.addSubview(tutorialButton)
        bodyBaseView.addSubview(googleDownloadButton)
        bodyBaseView.addSubview(uploadHeading)
        bodyBaseView.addSubview(uploadButton)
    }
    
    override func placeBodyViews() {
        tutorialHeading.topAnchor.constraint(equalTo: bodyBaseView.topAnchor, constant: 20).isActive = true
        tutorialHeading.centerXAnchor.constraint(equalTo: bodyBaseView.centerXAnchor).isActive = true
        tutorialHeading.widthAnchor.constraint(equalToConstant: 350).isActive = true
        tutorialHeading.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        tutorialButton.topAnchor.constraint(equalTo: tutorialHeading.bottomAnchor, constant: 30).isActive = true
        tutorialButton.leadingAnchor.constraint(equalTo: bodyBaseView.leadingAnchor, constant: 20).isActive = true
        tutorialButton.trailingAnchor.constraint(equalTo: bodyBaseView.trailingAnchor, constant: -20).isActive = true
        tutorialButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        googleDownloadButton.topAnchor.constraint(equalTo: tutorialButton.bottomAnchor, constant: 30).isActive = true
        googleDownloadButton.leadingAnchor.constraint(equalTo: bodyBaseView.leadingAnchor, constant: 20).isActive = true
        googleDownloadButton.trailingAnchor.constraint(equalTo: bodyBaseView.trailingAnchor, constant: -20).isActive = true
        googleDownloadButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        uploadHeading.topAnchor.constraint(equalTo: googleDownloadButton.bottomAnchor, constant: 80).isActive = true
        uploadHeading.centerXAnchor.constraint(equalTo: bodyBaseView.centerXAnchor).isActive = true
        uploadHeading.widthAnchor.constraint(equalToConstant: 350).isActive = true
        uploadHeading.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        uploadButton.topAnchor.constraint(equalTo: uploadHeading.bottomAnchor, constant: 30).isActive = true
        uploadButton.leadingAnchor.constraint(equalTo: bodyBaseView.leadingAnchor, constant: 20).isActive = true
        uploadButton.trailingAnchor.constraint(equalTo: bodyBaseView.trailingAnchor, constant: -20).isActive = true
        uploadButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    override func backButtonIsTapped(sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func nextButtonIsTapped(sender: UIButton) {
        print("Submit button is tapped.")
        showPopUp()
    }
    
    func startProgressView() {
        DispatchQueue.main.async {
            self.indicatorOverlay.isHidden = false
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        }
        
    }
    
    func stopProgressView() {
        DispatchQueue.main.async {
            self.indicatorOverlay.isHidden = true
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        }
    }
    
    func showPopUp() {
        let uiAlertController = UIAlertController(title: "Upload Success", message: "Your location history has been shared successfully for intersection calculation with the COVID-19 affected area.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {_ in
            print("Testing testing.")
        })
        uiAlertController.addAction(action)
        self.navigationController?.present(uiAlertController, animated: true, completion: nil)
    }
    
    func didPickDocuments(documents: [Document]?) {
        if let docs = documents {
            for doc in docs {
                if let jsonData = doc.data {
                    let locationHistory = try? JSONDecoder().decode(LocationHistory.self, from: jsonData)
                    if let localeHistory = locationHistory {
                        print(localeHistory.locations.count)
                    }
                } else {
                    print("No data is present in the document.")
                }
            }
        }
    }
    
    func didPickDocumentURL(urls: [URL]?) {
        guard let fileURLs = urls else {
            print("Received urls are empty.")
            return
        }
        
        for fileUrl in fileURLs {
            let nsData = try? NSData(contentsOf: fileUrl, options: NSData.ReadingOptions.mappedIfSafe)
            if let unwrappedNSData = nsData {
                let data = Data(referencing: unwrappedNSData)
                let locationHistory = try? JSONDecoder().decode(LocationHistory.self, from: data)
                if let localeHistory = locationHistory {
                    print(localeHistory.locations.count)
                    let correct = localeHistory.locations.filter({Int64($0.timestampMS) ?? 0 > 1580396400000}) // This is miliseconds time for the date 31st Jan 2020, 00:00:00
                    var locationHistories: [LocationHistoryServer] = []
                    for location in correct {
                        print(location.timestampMS)
                        
                        let milisecond = Int64(location.timestampMS) ?? 0
                        let dateVar = Date(timeIntervalSince1970: TimeInterval((milisecond / 1000)))
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "hh.mm.MM.dd.yyyy"
                        let timeStr = dateFormatter.string(from: dateVar)
                        dateFormatter.dateFormat = "mm"
                        let minuteTime = dateFormatter.string(from: dateVar)
                        if let minTime = Int(minuteTime) {
                            var newMinTime: Int = minTime / 10
                            newMinTime = newMinTime * 10
                            var newMinuteString = ""
                            if newMinTime == 0 {
                                newMinuteString = "00"
                            } else {
                                newMinuteString = String(newMinTime)
                            }
                            let times = timeStr.split(separator: ".")
                            var finalTime: String = times[0] + "." + newMinuteString + "."
                            finalTime = finalTime + times[2] + "."
                            finalTime = finalTime + times[3] + "." + times[4]
                            
                            locationHistories.append(LocationHistoryServer(timeslot: finalTime, lat: String(location.latitudeE7), long: String(location.longitudeE7), status: "unknown"))
                        }
                    }
                    let locationHistoryForServer = LocationHistoryForServer(id: UUID().uuidString, locationHistory: locationHistories)
                    Service.shared.sendData(inputData: locationHistoryForServer)
                    stopProgressView()
                } else {
                    print("JSON file couldn't be parsed.")
                    stopProgressView()
                }
            } else {
                print("Data is nil or couldn't be read.")
                stopProgressView()
            }
        }
    }
    
    @objc func startTutorialButtonIsPressed(sender: UIButton) {
        print("Tutorial button is pressed.")
    }
    
    @objc func startGoogleTakeoutIsPressed(sender: UIButton) {
        print("Google takeout button is pressed.")
        
        let urlString = "https://takeout.google.com/"
        
        if let url = URL(string: urlString) {
            let vc = SFSafariViewController(url: url)
            vc.delegate = self
            
            present(vc, animated: true)
        }
    }
    
    @objc func uploadFileIsPressed(sender: UIButton) {
        print("Upload file button is pressed.")
        documentPicker.present(from: view)
        startProgressView()
    }
}