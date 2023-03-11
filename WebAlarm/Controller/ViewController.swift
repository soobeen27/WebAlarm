//
//  ViewController.swift
//  WebAlarm
//
//  Created by Soo Jang on 2023/03/03.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    
    let siteInfoManager = SiteInfoManager()
    var data: [FavSites] = [FavSites(urlString: "https://m.comic.naver.com/webtoon/weekday", img: UIImage(systemName: "n.square")!),FavSites(urlString: "https://webtoon.kakao.com", img: UIImage(systemName: "k.square")!) ]
    
    var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout ()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(SitesCell.self, forCellWithReuseIdentifier: "SitesCell")
        cv.translatesAutoresizingMaskIntoConstraints=false
        return cv
    }()
    
    let tableView = UITableView()
    
    lazy var monBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("월", for: .normal)
        btn.tag = 1
        btn.backgroundColor = .gray
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var tueBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("화", for: .normal)
        btn.tag = 2
        btn.backgroundColor = .gray
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    lazy var wedBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("수", for: .normal)
        btn.tag = 3
        btn.backgroundColor = .gray
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    lazy var thuBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("목", for: .normal)
        btn.tag = 4
        btn.backgroundColor = .gray
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    lazy var friBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("금", for: .normal)
        btn.tag = 5
        btn.backgroundColor = .gray
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    lazy var satBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("토", for: .normal)
        btn.tag = 6
        btn.backgroundColor = .gray
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    lazy var sunBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("일", for: .normal)
        btn.tag = 7
        btn.backgroundColor = .gray
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var buttons = [monBtn,tueBtn,wedBtn,thuBtn,friBtn,satBtn,sunBtn]
    
    lazy var btnSV: UIStackView = {
        let sv = UIStackView(arrangedSubviews: buttons)
        sv.axis = .horizontal
        sv.spacing = 5
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        setNavigationView()
        setUI()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // 모든 버튼에 설정 변경
        buttons.forEach { button in
            button.clipsToBounds = true
            button.layer.cornerRadius = button.bounds.height / 2
        }
    }
    
    func setTV() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 60
        tableView.register(FavLinkCell.self, forCellReuseIdentifier: "FavLinkCell")
        
    }
    
    func setNavigationView() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()  // 불투명으로
        
        //        self.navigationItem.leftBarButtonItem = self.sideBarBtn
        //        self.navigationItem.rightBarButtonItem = self.addFavBtn
        //appearance.configureWithTransparentBackground()  // 투명으로
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationItem.title = "Web Alarm"
        navigationController?.navigationBar.tintColor = .blue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        
    }
    
    
    func setUI() {
        view.addSubview(collectionView)
        view.addSubview(btnSV)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.heightAnchor.constraint(equalToConstant: view.frame.width/2),
            
            btnSV.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 15),
            btnSV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            btnSV.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            btnSV.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height/2, height: collectionView.frame.height/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let webVC = WebViewController()
        //        let array = memberListManager.getMemberList()
        //        detailVC.member = array[indexPath.row]
        webVC.urlString = data[indexPath.row].urlString
        navigationController?.pushViewController(webVC, animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SitesCell", for: indexPath) as! SitesCell
        cell.data = self.data[indexPath.row].img
        return cell
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}

