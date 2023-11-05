//
//  ViewController.swift
//  ThirdNewApp_codedLogin
//
//  Created by 심현희 on 2023/10/31.
//

import UIKit

// 💡 일반적으로 class앞에 final 을 붙임 => 빨라짐 (다이렉트 디스패치가 일어나게함) / 대부분 상속불필요한 뷰컨트롤러에는 final 키워드 필수!
final class ViewController: UIViewController {
    // 💡 대부분의 변수는 private 을 붙이는게 좋다
    private let loginView = LoginView()
    
    override func loadView() {
        view = loginView
    }
    // MARK: - 뷰디드로드 함수
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddTarget()
    }
    
    
    func setupAddTarget() {
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
      
        loginView.passwordResetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)

        
    }
    
    
    
    
    
    // MARK: - 리셋버튼 메서드
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
    
    
    
    // MARK: - 로그인 버튼 메서드
    // 로그인 버튼이 눌렸을때의 메서드
    @objc func loginButtonTapped() {
        print("로그인 버튼이 눌렸습니다")
    /*반드시 present 메서드를 사용하기 위해서는 viewController 객체안에 해당 loginButtonTapped 매서드가 구현이 되어 있어야함
        let vc = secondViewcontroller()
        present.(vc, animated: true)
    */
        
    }
    
    
    
}
