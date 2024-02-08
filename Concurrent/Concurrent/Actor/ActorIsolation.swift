//
//  ActorIsolation.swift
//  Concurrent
//
//  Created by Junyoo on 2/8/24.
//

import SwiftUI

struct ActorIsolation: View {
    let bankAccount = BankAccount(accountNumber: 1, balance: 1000)
    @State private var number = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Account Number: \(number)")
            Button("isolated Action") {
                isolatedAction()
            }
            Button("nonisolated Action") {
                isolatedAction()
            }
        }
    }
    func isolatedAction() {
        Task {
            number = await bankAccount.getIDNumberIsolated() //actor의 메소드를 사용할땐 task, await 키워드 사용
        }
    }
    
    func nonisolatedAction() {
        number = bankAccount.getIDNumberNonIsolated()
        /*
         accountNumber를 상수로 선언 -> actor는 race condition이 발생하지 않는것을 보장
         getIDNumberNonIsolated 메소드 앞에 nonisolated를 붙여 사용하는곳에서 task, await 키워드 없이 사용 가능
         */
    }
}

actor BankAccount {
    let accountNumber: Int
    var balance: Double
    
    init(accountNumber: Int, balance: Double) {
        self.accountNumber = accountNumber
        self.balance = balance
    }
}

extension BankAccount {
    enum BankError: Error {
        case insufficientFunds
    }
    
    func transfer(amount: Double, to other: BankAccount) async throws {
        if amount > self.balance {
            throw BankError.insufficientFunds
        }
        
        print("Transferring \(amount) from \(accountNumber) to \(other.accountNumber)")
        
        self.balance = balance - amount
        await other.deposit(amount: amount)
//        other.balance = other.balance + amount
        /*
        error: Actor-isolated property 'balance' can not be mutated on a non-isolated actor instance
               Actor-isolated property 'balance' can not be referenced on a non-isolated actor instance
        
         BankAccount가 class였다면 해당 오류가 안났을것 -> data races 발생할 수 있음
         other.balance는 other self에서만 참조될 수 있기 때문에 other.balance를 참조하면 에러 발생
         
         other.accountNumber를 출력하기 위해 참조했는데 되는 이유 -> 상수로 선언했기 때문에 -> cross-actor reference
         
         아래 deposit 함수를 확장하여 balance 속성에 접근 및 수정할 수 있게 한 후 호출하여 해결
         -> 다른 actor의 balance 속성에 접근하는 동시에 상호작용이 가능
        */
    }
    
    func deposit(amount: Double) {
        assert(amount >= 0)
        balance = balance + amount
    }
}

extension BankAccount {
    func getIDNumberIsolated() -> Int {
        accountNumber
    }
    
    nonisolated func getIDNumberNonIsolated() -> Int {
        accountNumber
    }
}
