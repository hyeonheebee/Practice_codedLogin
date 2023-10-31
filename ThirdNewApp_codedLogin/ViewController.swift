//
//  ViewController.swift
//  ThirdNewApp_codedLogin
//
//  Created by 심현희 on 2023/10/31.
//

import UIKit

class ViewController: UIViewController {
    

    
    // 클로저의 실행문 타입으로 구현하기 // 이메일 텍스트필드가 올라가는 view
    private lazy var emailTextFieldView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.backgroundColor = UIColor.darkGray
        view.addSubview(emailTextField)
        view.addSubview(emailInfoLabel)
     // 메모리에 있는 emailTextFieldView 을 실제로 화면에 보여지도록 함(view에 표시)
     // 이미 UIViewController 에는 view라는 속성이 있음
     //  emailTextFieldView를 let이 아닌 lazy var 로 설정하면 추가 가능한 코드, view가 먼저 생성되야 하므로 emailTextFieldView를 나중에 생성될 수 있게 하기 위함
        return view
    }()
    // 클로저가 실행을 하자마자 view 저장속성이 생기고 view 에 셋팅을 다 한 후 emailTextFieldView 변수에 담김
    
    
    // 일반적으로 클로저 실행문 내에서는 좀 더 간단한 형태의 속성으로 선언해서 사용함
    private var emailInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일주소 또는 전화번호"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.white
        return label
    }()
    
    // 이메일 텍스트필드 메모리에 올리기
    private lazy var emailTextField: UITextField = {
        var tf = UITextField()
        tf.frame.size.height = 48
        tf.backgroundColor = .clear     // 투명으로 설정
        tf.textColor = .white
        tf.tintColor = .white
        tf.autocapitalizationType = .none       // 자동으로 앞글자를 대문자로 바꿔주는 여부
        tf.autocorrectionType = .no         // 자동으로 틀린글자 잡아주는 기능 여부
        tf.spellCheckingType = .no          // 자동으로 스펠링체크 기능 여부
        tf.keyboardType = .emailAddress     // 키보드 타입 email설정
        // tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    
    // 패스워드 텍스트필드가 올라가는 view 메모리 올리기
    private let passwordTextFieldView: UIView = {
        let view = UIView()
        view.frame.size.height = 48
        view.backgroundColor = #colorLiteral(red: 1, green: 0.3269024491, blue: 0, alpha: 1)
        view.layer.cornerRadius = 5
        view.clipsToBounds = true

        return view
    }()
    
    // 패스워드 텍스트필드의 안내문구 메모리 올리기
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.white
        return label
    }()
    
    // 비밀번호 텍스트필드 메모리올리기
    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        tf.frame.size.height = 48
        tf.backgroundColor = .clear
        tf.textColor = .white
        tf.tintColor = .white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.isSecureTextEntry = true     // 비밀번호를 가리는 설정
        tf.clearsOnBeginEditing = false
        return tf
    }()
    
    
    // 비밀번호 텍스트필드 내 '표시' 버튼 메모리올리기
    private let passwordSecureButton: UIButton = {
        let button = UIButton(type: .custom)    // 보통 system 혹은 custom을 주로 사용
        button.setTitle("표시", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.83, green: 0.83, blue: 0.83, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)     // 타이틀레이블 크기
        // button.addTarget(self, action: #selector(passwordSecureModeSetting), for: .touchUpInside)
        return button
    }()
    
    // 로그인 버튼 메모리올리기
    private let loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        button.setTitle("로그인", for: .normal)
        button.isEnabled = false    //처음에는 버튼을 비활성화 => 조건이 맞으면 활성화되도록
        
        return button
    }()
    
    // 스택 뷰 설정
    lazy var stackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [emailTextFieldView,passwordTextFieldView,loginButton])
        st.spacing = 18
        st.axis = .vertical     // 세로로 묶어줄지 가로로 묶어줄지
        st.distribution = .fillEqually      // 분배방식여부
        st.alignment = .fill        // 정렬방식여부
        return st
    }()
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        
    }

    
    func makeUI() {
        // 💡주의! 코드로 오토레이아웃 셋팅을 위한 사전 셋팅(필수) => 코드로 UI작성시 자동으로 frame 기준으로 오토레이아웃으로 잡아주는 기능을 끄는 코드
        emailInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // 오토레이아웃 셋팅(add New Constraints 했던 부분을 코드로 구현) 기준점이 필요
        // 왼쪽 앵커 잡기(닻 내리기, 기준점에서 왼쪽이 얼마만큼)
        emailInfoLabel.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8).isActive = true
        emailInfoLabel.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: 8).isActive = true
        emailInfoLabel.centerYAnchor.constraint(equalTo: emailTextFieldView.centerYAnchor).isActive = true
 
        
    }

}

