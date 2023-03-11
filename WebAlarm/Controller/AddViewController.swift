//
//  AddViewController.swift
//  WebAlarm
//
//  Created by Soo Jang on 2023/03/10.
//

import UIKit

class AddViewController: UIViewController {

    let week = ["월요일","화요일", "수요일", "목요일", "금요일", "토요일", "일요일"]
    
    let pickerView = UIPickerView()
    
    let testlabel: UILabel = {
       let label = UILabel()
        label.text = "modal test"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var cancelBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("취소", for: .normal)
        btn.setTitleColor(UIColor.blue, for: .normal)
        btn.addTarget(self, action: #selector(dismissModal), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var addBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("확인", for: .normal)
        btn.setTitleColor(UIColor.blue, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        pickerView.delegate = self
        pickerView.dataSource = self
        view.backgroundColor = .white

        // Do any additional setup after loading the view.
    }
    
    func setPKV() {
    }
    
    func setUI() {
        view.addSubview(testlabel)
        view.addSubview(cancelBtn)
        view.addSubview(addBtn)
        view.addSubview(pickerView)
        
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            testlabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testlabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            cancelBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            cancelBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            addBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            addBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            pickerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//            pickerView.heightAnchor.constraint(equalToConstant: view.frame.size.width / 2)
        ])
    }
    
    @objc func dismissModal() {
        dismiss(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AddViewController:UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        week.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return week[row]
    }

    
    
}
