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
    
    /*
    // 클로저의 실행문 타입으로 구현하기
    lazy var emailTextFieldView: UIView = {
        let view = UIView
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor.darkGray
        view.addSubview(emailTextFieldView) //  emailTextFieldView를 let이 아닌 lazy var 로 설정하면 추가 가능한 코드, view가 먼저 생성되야 하므로 emailTextFieldView를 나중에 생성될 수 있게 하기 위함
        return view
    }()
    // 클로저가 실행을 하자마자 view 저장속성이 생기고 view 에 셋팅을 다 한 후 emailTextFieldView 변수에 담김
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()

    }

    
    func makeUI() {
        // 모서리를 둥글게 처리하는 코드
        emailTextFieldView.layer.cornerRadius = 8
        emailTextFieldView.layer.masksToBounds = true
        
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

