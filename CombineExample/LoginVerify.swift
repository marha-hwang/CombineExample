//
//  LoginVerify.swift
//  CombineExample
//
//  Created by haram on 2/1/25.
//

import Foundation
import SwiftUI
import Combine

/**
  알아둘것
 1. @State와 @StateObject는 무엇일까?
 - @State :  SwiftUI에서 뷰의 상태값을 관리하고 갑 변화 발생시 뷰를 업데이트하기 위한 프로퍼티래퍼
 - @Binding : 부모뷰의 상태값을 자식뷰에서 전달받아 사용하기 위해 자식뷰에 선언되는 프로퍼티래퍼
 - @StateObject :
 - @EnverimentObject :
 
 2. ObservableObject는 무엇일까?
 3. store함수와 AnyCancellable클래스의 관계는 무엇일까?
 */

struct LoginVerify:View{
    
    @StateObject private var viewModel = LoginVerifyViewModel()
    
    var body: some View{
        VStack(alignment:.center){
            HStack(){
                Text("ID")
                TextField("아이디를 입력하세요", text: $viewModel.id)
            }
            HStack(){
                Text("PASSWORD")
                TextField("비밀번호를 입력하세요", text: $viewModel.pass)
            }
            Button("로그인"){
                
            }
            .disabled(viewModel.btnIsVisible)
        }
    }
}

final class LoginVerifyViewModel:ObservableObject{
    @Published var id:String = ""
    @Published var pass:String = ""
    @Published var btnIsVisible:Bool = true

    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // 텍스트 값이 변경될 때마다 처리할 작업을 Combine을 사용하여 연결
        $id
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main) // 입력이 끝난 후 300ms 대기
            .removeDuplicates() // 중복되는 텍스트 입력 방지
            .sink {[weak self] newText in
                // 텍스트가 변경될 때마다 실행할 코드
                print("입력된 텍스트: \(newText)")
                if newText.count > 7 && self?.pass.count ?? 0 > 7{
                    self?.btnIsVisible = false
                }
                else{ self?.btnIsVisible = true }
            }
            .store(in: &cancellables) // 구독 해제를 위한 취소 저장소에 저장
        
        $pass
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main) // 입력이 끝난 후 300ms 대기
            .removeDuplicates() // 중복되는 텍스트 입력 방지
            .sink {[weak self]newText in
                // 텍스트가 변경될 때마다 실행할 코드
                print("입력된 텍스트: \(newText)")
                if newText.count > 7 && self?.id.count ?? 0 > 7{
                    self?.btnIsVisible = false
                }
                else{ self?.btnIsVisible = true }
            }
            .store(in: &cancellables) // 구독 해제를 위한 취소 저장소에 저장
    }
}

#Preview {
    LoginVerify().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
