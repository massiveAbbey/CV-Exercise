//
//  ViewController.swift
//  CV Express
//
//  Created by Abbey Ola on 12/06/2019.
//  Copyright © 2019 Abbey. All rights reserved.
//

import UIKit
import Kingfisher
import EasyPeasy

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let appService = AppService(apiService: ApiService())

    let profileimageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        imageView.layer.borderWidth = 2
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true

        return imageView
    }()

    let nameLable: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        label.textAlignment = .center
        return label
    }()

    let jobTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.textAlignment = .center
        return label
    }()

    let addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }()

    let coverLetterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()

    let scrollview = UIScrollView()


    let educationTableView = UITableView()
    let experienceTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        experienceTableView.delegate = self
        experienceTableView.dataSource = self
        educationTableView.delegate = self
        educationTableView.dataSource = self

        experienceTableView.register(ExperienceCell.self, forCellReuseIdentifier: "ExperienceCellID")
        experienceTableView.customise()

        educationTableView.register(EducationCell.self, forCellReuseIdentifier: "EducationCellID")
        educationTableView.customise()

        setUpViews()
        loadCV()
    }

    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        scrollview.contentSize = CGSize(width: view.bounds.width, height: 1100)
    }

    func setUpViews() {
        addSpinner()
        view.addSubview(scrollview)
        let experienceHeader = UILabel()
        experienceHeader.font = UIFont(name: "HelveticaNeue", size: 16)
        experienceHeader.textAlignment = .left
        experienceHeader.text = "Experience"
        scrollview.addSubview(experienceHeader)
        scrollview.contentInset = .zero

        let educationHeader = UILabel()
        educationHeader.font = UIFont(name: "HelveticaNeue", size: 16)
        educationHeader.textAlignment = .left
        educationHeader.text = "Education"
        view.addSubview(educationHeader)

        let topBanner = UIImageView()
        topBanner.clipsToBounds = true
        topBanner.image = #imageLiteral(resourceName: "banner")
        scrollview.addSubview(topBanner)
        scrollview.addSubview(profileimageView)
        scrollview.addSubview(nameLable)
        scrollview.addSubview(jobTitleLabel)
        scrollview.addSubview(addressLabel)
        scrollview.addSubview(coverLetterLabel)
        scrollview.addSubview(seperatorView)
        scrollview.addSubview(experienceTableView)
        scrollview.addSubview(educationTableView)

        scrollview.easy.layout([
            Top(),
            Bottom(),
            Width().like(view, .width),
            ])
        scrollview.alwaysBounceVertical = false

        topBanner.easy.layout(Top(), Right(), Left(), Height(150), Width().like(scrollview, .width))
        profileimageView.easy.layout(
            CenterX().to(topBanner),
            Top(-60).to(topBanner),
            Height(150), Width(150))

        nameLable.easy.layout(
            Top(16).to(profileimageView),
            CenterX().to(scrollview))

        jobTitleLabel.easy.layout(
            Top(4).to(nameLable),
            CenterX().to(scrollview))

        addressLabel.easy.layout(
            Top(4).to(jobTitleLabel),
            CenterX().to(scrollview))

        coverLetterLabel.easy.layout(
            Top(8).to(addressLabel),
            CenterX().to(scrollview),
            Left(16),
            Right(16))

        seperatorView.easy.layout(
            Top(16).to(coverLetterLabel),
            Right(),
            Left(),
            Height(6))

        experienceHeader.easy.layout(
            Top(16).to(seperatorView),
            Right(),
            Left(8))

        experienceTableView.easy.layout(
            Top(8).to(experienceHeader),
            Right(8),
            Left(8),
            Height(240))

        educationHeader.easy.layout(
            Top(16).to(experienceTableView),
            Right(),
            Left(8))

        educationTableView.easy.layout(
            Top(8).to(educationHeader),
            Right(8),
            Left(8),
            Height(240))
    }

    private func loadCV() {
        activityIndicatorStart()
        appService.getCV()

        appService.updateLoadingState = {
            let _ = self.appService.isLoading ? self.activityIndicatorStart() : self.activityIndicatorStop()
        }

        appService.networkTaskFinishWithError = {
            if let error = self.appService.error {
                print(error.localizedDescription)
            }
        }

        appService.didFinishNetworkTask = {
            self.ready()
        }
    }

    let spinner = UIActivityIndicatorView(style: .whiteLarge)

    private func addSpinner() {
        spinner.color = .black
        spinner.center = view.center
        scrollview.addSubview(spinner)
    }
    private func activityIndicatorStart() {
        spinner.startAnimating()
    }

    private func activityIndicatorStop() {
        spinner.stopAnimating()
    }

    func ready() {
        guard let cv = appService.cv else { return }
        updateUI(cv)

        experienceTableView.reloadData()
        educationTableView.reloadData()
    }

    func updateUI(_ cv: CV) {
        let url = URL(string: cv.pictureUrl)
        profileimageView.kf.setImage(with: url)
        nameLable.text = cv.name
        jobTitleLabel.text = cv.title
        addressLabel.text = cv.address
        coverLetterLabel.text = cv.cover
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cv = appService.cv else { return 0 }

        if tableView == educationTableView {
            return cv.education.count
        } else if tableView == experienceTableView {
            return cv.experience.count
        }

        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == educationTableView {
             guard let cell = tableView.dequeueReusableCell(withIdentifier: "EducationCellID", for: indexPath) as? EducationCell, let education = appService.cv?.education else { return UITableViewCell() }
            cell.schoolLabel.text = education[indexPath.row].school
            cell.degreeLAbel.text = ("\(education[indexPath.row].degree) \(education[indexPath.row].major)")
            cell.yearLabel.text = String(education[indexPath.row].year)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceCellID", for: indexPath) as? ExperienceCell, let experience = appService.cv?.experience else { return UITableViewCell() }
            cell.companyLabel.text = experience[indexPath.row].company
            cell.jobTitleLabel.text = experience[indexPath.row].jobTitle
            cell.dateLabel.text = ("\(experience[indexPath.row].startDate) - \(experience[indexPath.row].endDate)")
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}

extension UITableView {
    func customise() {
        alwaysBounceVertical = false;
        allowsSelection = false
        layer.masksToBounds = true
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor
    }
}
