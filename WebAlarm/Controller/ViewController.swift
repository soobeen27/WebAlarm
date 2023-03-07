//
//  ViewController.swift
//  WebAlarm
//
//  Created by Soo Jang on 2023/03/03.
//

import UIKit
import SafariServices

class ViewController: UIViewController, SFSafariViewControllerDelegate {
    
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
    
    lazy var testImgView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        setNavigationView()
        setUI()
        let url = NSURL(string: data[0].urlString)! as URL
        siteInfoManager.getThumbnail(from: url) { img in
            print(img)
            DispatchQueue.main.async {
                if let thumbnailImage = img {
                    self.testImgView.image = thumbnailImage
                    print(thumbnailImage)
                } else {
                    self.testImgView.image = nil
                }
            }
            
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    func setNavigationView() {
        view.backgroundColor = .gray
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()  // 불투명으로
        
        //        self.navigationItem.leftBarButtonItem = self.sideBarBtn
        //        self.navigationItem.rightBarButtonItem = self.addFavBtn
        //appearance.configureWithTransparentBackground()  // 투명으로
        navigationItem.title = "Web Alarm"
        navigationController?.navigationBar.tintColor = .blue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
    }
    
    func setUI() {
        view.addSubview(collectionView)
        view.addSubview(testImgView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.heightAnchor.constraint(equalToConstant: view.frame.width/2),
            
            testImgView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            testImgView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            testImgView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            testImgView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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


struct FavSites {
    let urlString: String
    let img: UIImage
}

