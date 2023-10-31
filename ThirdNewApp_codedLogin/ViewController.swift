//
//  ViewController.swift
//  ThirdNewApp_codedLogin
//
//  Created by 심현희 on 2023/10/31.
//

import UIKit

class ViewController: UIViewController {
    
    let emailTextFieldView = UIView()
    // 메모리에 올리기
    

    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()

    }

    
    func makeUI() {
        
        emailTextFieldView.backgroundColor = UIColor.darkGray
        // 배경색상 셋팅
        view.addSubview(emailTextFieldView)
        // 메모리에 있는 emailTextFieldView 을 실제로 화면에 보여지도록 함(view에 표시)
        // 이미 UIViewController 에는 view라는 속성이 있음
        
        // 💡주의! 코드로 오토레이아웃 셋팅을 위한 사전 셋팅(필수) => 코드로 UI작성시 자동으로 frame 기준으로 오토레이아웃으로 잡아주는 기능을 끄는 코드
        emailTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        
        // 오토레이아웃 셋팅(add New Constraints 했던 부분을 코드로 구현) 기준점이 필요
        // 왼쪽 앵커 잡기(닻 내리기, 기준점에서 왼쪽이 얼마만큼)
        emailTextFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        // isActive = true까지 해줘야 설정이 마무리 되는 구조
        
        // 오른쪽 앵커 잡기(닻 내리기, 기준점에서 오른쪽이 얼마만큼)
        emailTextFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        // -30 임에 유의
        
        // 위쪽 앵커 잡기(닻 내리기, 기준점에서 위에가 얼마만큼)
        emailTextFieldView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        
        // 높이 설정
        emailTextFieldView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        // 기준점이 없으므로 equlToConstant 파라미터 메서드 사용
        
    }

}

