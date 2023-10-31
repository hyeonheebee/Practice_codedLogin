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
        //💡 주의! 순서가 중요하다(위에 있는 코드가 가장 아래에 깔림)
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
        
        // 값이 변경될때마다 해당 함수를 호출하는 코드
        tf.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        return tf
    }()
    
    
    // 패스워드 텍스트필드가 올라가는 view 메모리 올리기
    private lazy var passwordTextFieldView: UIView = {
        let view = UIView()
        view.frame.size.height = 48
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.addSubview(passwordTextField)
        view.addSubview(passwordInfoLabel)
        view.addSubview(passwordSecureButton)
        return view
    }()
    
    // 패스워드 텍스트필드의 안내문구 메모리 올리기
    private let passwordInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.white
        return label
    }()
    
    // 비밀번호 텍스트필드 메모리올리기
    private lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tf.frame.size.height = 48
        tf.backgroundColor = .clear
        tf.textColor = .white
        tf.tintColor = .white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.isSecureTextEntry = true     // 비밀번호를 가리는 설정
        tf.clearsOnBeginEditing = false
        
        // 값이 변경될때마다 해당 함수를 호출하는 코드
        tf.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        return tf
    }()
    
    
    // 비밀번호 텍스트필드 내 '표시' 버튼 메모리올리기
    private lazy var passwordSecureButton: UIButton = {
        let button = UIButton(type: .custom)    // 보통 system 혹은 custom을 주로 사용
        button.setTitle("표시", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.83, green: 0.83, blue: 0.83, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)     // 타이틀레이블 크기
        button.addTarget(self, action: #selector(passwordSecureModeSetting), for: .touchUpInside)
        return button
    }()
    
    // 로그인 버튼 메모리올리기
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        button.setTitle("로그인", for: .normal)
        button.isEnabled = false    //처음에는 버튼을 비활성화 => 조건이 맞으면 활성화되도록
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
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
    
    
    private lazy var passwordResetButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("비밀번호 재설정", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.tintColor = .white
        button.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    
    
    // 스택 뷰 내의 3개의 텍스트필드의 각 높이 설정
    private let textViewHeight: CGFloat = 48
    
    
    // 텍스트 입력관련 UI변경을 위한 델리게이트 패턴 구현 중 오토레이아웃 변경을 위한 변수생성
    // 내가 변경하고 싶은 제약(여기서는 가운데 정렬제약) 을 변수에 담음
    
    lazy var emailInfoLabelCenterYConstraint = emailInfoLabel.centerYAnchor.constraint(equalTo: emailTextFieldView.centerYAnchor)
    lazy var passwordInfoLabelCenterYConstraint = passwordInfoLabel.centerYAnchor.constraint(equalTo: passwordTextFieldView.centerYAnchor)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        makeUI()
    }

    
    func makeUI() {
        
        view.backgroundColor = .black
        // 가장 아래있는 뷰에 이메일 텍스트 뷰 올리기
        view.addSubview(stackView)
        view.addSubview(passwordResetButton)
        
        // 💡주의! 코드로 오토레이아웃 셋팅을 위한 사전 셋팅(필수) => 코드로 UI작성시 자동으로 frame 기준으로 오토레이아웃으로 잡아주는 기능을 끄는 코드
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        emailInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false

        passwordInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordSecureButton.translatesAutoresizingMaskIntoConstraints = false
        
        passwordResetButton.translatesAutoresizingMaskIntoConstraints = false
        // 오토레이아웃 셋팅(add New Constraints 했던 부분을 코드로 구현) 기준점이 필요
        
        // 배열로 넣어줄 수 있음(익숙해진 후에는 이렇게 사용)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            // 각 텍스트뷰의 높이의 3개만큼의 높이 + 36만큼의 높이를 가진 스택뷰 설정
            stackView.heightAnchor.constraint(equalToConstant: textViewHeight*3 + 36),
            
            
            emailInfoLabel.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8),
            emailInfoLabel.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: 8),
            
            // 고정으로 만들면 안됨
            // emailInfoLabel.centerYAnchor.constraint(equalTo: emailTextFieldView.centerYAnchor),
            // 만든 변수로 설정해줘야함
            emailInfoLabelCenterYConstraint,
            
            emailTextField.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8),
            emailTextField.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: 8),
            emailTextField.topAnchor.constraint(equalTo: emailTextFieldView.topAnchor, constant: 15),
            emailTextField.bottomAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor, constant: 2),
            
            
            passwordInfoLabel.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 8),
            passwordInfoLabel.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: 8),
            // passwordInfoLabel.centerYAnchor.constraint(equalTo: passwordTextFieldView.centerYAnchor),
            // 만든 변수로 설정해줘야함
            passwordInfoLabelCenterYConstraint,
            

            passwordTextField.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 8),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: 8),
            passwordTextField.topAnchor.constraint(equalTo: passwordTextFieldView.topAnchor, constant: 15),
            passwordTextField.bottomAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: 2),

            
            passwordSecureButton.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -8),    // 끝에 붙어있는 표시버튼이므로 trailing 만 사용
            passwordSecureButton.topAnchor.constraint(equalTo: passwordTextFieldView.topAnchor, constant: 15),
            passwordSecureButton.bottomAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: -15),
            
            passwordResetButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 30),
            passwordResetButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30),
            passwordResetButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            passwordResetButton.heightAnchor.constraint(equalToConstant: textViewHeight)
            
        ])
    
        
        
    }
    
    // selector로 동작하므로 @objc 키워드 필요
    @objc func passwordSecureModeSetting() {
        passwordTextField.isSecureTextEntry.toggle()
        // 보통 bool 타입은 toggle 메서드 제공하여 토글시 true <-> false 가능
        // print("표시버튼이 눌렸습니다")
    }
    
    
    
    @objc func resetButtonTapped() {
        // print("reset button 눌림")
        
        // controller 만들기
        let alert = UIAlertController(title: "비밀번호 바꾸기", message: "비밀번호를 바꾸시겠습니까?", preferredStyle: .alert)
        // preferredStyle 이 alert면 가운데 뜨고 actionSheet면 토스트처럼 올라옴
        
        // controller 안에 배치시킬 action 만들기
        let success = UIAlertAction(title: "확인", style: .default) { action in
            print("확인버튼이 눌렸습니다")
            print(action.title!)
            // "확인" 을 누르고 나면 action 실행 (클로저 실행, action 은 클로저의 파라미터일뿐 사용해도 안해도그만)
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel) { action in
            print("취소버튼이 눌렸습니다")
        }
        
        // controller에 action 올려주기 (버튼생성)
        alert.addAction(success)
        alert.addAction(cancel)
        
        // 다음화면으로 넘어가는 메서드 present
        // 이 alert창이 실제로 다음화면임
        present(alert, animated: true, completion: nil)
    }
    
    
    // 로그인 버튼이 눌렸을때의 메서드
    @objc func loginButtonTapped() {
        print("로그인 버튼이 눌렸습니다")
    }
    
    // 화면이 터치되면 키보드가 내려감(first Responder 없어짐)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

}


// 텍스트를 입력할때 레이블이 위로 올라가게 UI를 변경하고 싶음 => 델리게이트 패턴으로 구현필요
// 메서드 등을 분리하기 위해서 이렇게 확장해서 delegate 프로토콜을 채택함
extension ViewController: UITextFieldDelegate {
    // 텍스트필드의 입력이 시작되는 시점에서의 메서드 내용구현
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField {
            emailTextFieldView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            emailInfoLabel.font = UIFont.systemFont(ofSize: 11)
            // 오토레이아웃 업데이트(label을 이동시킴)
            emailInfoLabelCenterYConstraint.constant = -13
        }
        if textField == passwordTextField {
            passwordTextFieldView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            passwordInfoLabel.font = UIFont.systemFont(ofSize: 11)
            // 오토레이아웃 업데이트(label을 이동시킴) -13 => 올라감
            passwordInfoLabelCenterYConstraint.constant = -13
        }
        
        // 애니메이션 기능 추가
        // 런루프동안 띄엄띄엄 그리는게 아닌 그림을 그리는 동안 자연스럽게 그림을 그릴 수 있게하는 코드
        UIView.animate(withDuration: 0.3) {
            self.stackView.layoutIfNeeded()
        }
    }
    
    // 텍스트필드의 입력이 끝나는 시점에서의 메서드 내용구현
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField {
            emailTextFieldView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            if emailTextField.text == "" {
                emailInfoLabel.font = UIFont.systemFont(ofSize: 18)
                // 오토레이아웃 업데이트(label을 원래자리로 이동시킴)
                emailInfoLabelCenterYConstraint.constant = 0
            }
        }
        if textField == passwordTextField {
            passwordTextFieldView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            if passwordTextField.text == "" {
                passwordInfoLabel.font = UIFont.systemFont(ofSize: 18)
                // 오토레이아웃 업데이트(label을 원래자리로 이동시킴)
                passwordInfoLabelCenterYConstraint.constant = 0
            }
        }
        // 애니메이션 기능 추가
        // 런루프동안 띄엄띄엄 그리는게 아닌 그림을 그리는 동안 자연스럽게 그림을 그릴 수 있게하는 코드
        UIView.animate(withDuration: 0.3) {
            self.stackView.layoutIfNeeded()
        }
        
    }
    
    
    // 텍스트필드가 변경될때 호출되는 메서드
    @objc func textFieldEditingChanged(textField: UITextField) {
        // 첫번째 글자가 있는데 그 문자가 빈문자열이면 빈문자를 입력해주고 벗어나는 코드
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            // 둘다 입력이 되어있고(let 바인딩이 되고) isEmpty 가 false 즉 비어있지 않다면 진행, 아니라면 else 문으로 빠져나가기
            let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty
        else {
            loginButton.backgroundColor = .clear
            loginButton.isEnabled = false
            return
        }
        loginButton.backgroundColor = .red
        loginButton.isEnabled = true
    }
    
    
    
}
