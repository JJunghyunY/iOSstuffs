//
//  Actor.swift
//  Concurrent
//
//  Created by Junyoo on 2/8/24.
//

import SwiftUI

struct Actor: View {
    let classCounter = ClassCounter()
    let actorCounter = ActorCounter()

    var body: some View {
        VStack(spacing: 20) {
            Text("Hello, world!")
            Button("Increase - Class") {
                classAction()
            }
            Button("Increase - Actor") {
                actorAction()
            }
        }
    }
    func classAction() {
        Task.detached {
            print(classCounter.increment())
        }
        Task.detached {
            print(classCounter.increment())
        }
        //예측할 수 없는 값이 출력됨
        
        /*
         classAction 함수는 두 개의 다른 쓰레드에서 Counter 클래스의 increment() 메서드를 동시 호출.
         첫 번째는 백그라운드에서 실행, 두 번째는 메인 스레드에서 실행.
         이러한 동시성 작업은 data race를 발생.
         data race: 두 개 이상의 개별 쓰레드가 동시에 동일한 데이터에 접근하고, 하나 이상이 쓰기(write)를 시도할 때 발생.
         
         위 상황에서는 서로 다른 스레드가 동시에 counter 객체의 increment() 메서드를 호출.
         count 속성을 변경하는 것은 데이터의 무결성을 보장하지 못함.
         */
    }
    
    func actorAction() {
        Task.detached {
            print(await actorCounter.increment())
        }
        Task.detached {
            print(await actorCounter.increment())
        }
        //1 2... 안전하게 값이 출력됨
        
        /*
        Actor는 shared mutable state in concurrent programming을 위한 동기화 메커니즘.
        Actor는 clas와 유사하지만, 한 번에 하나의 작업만 변경 가능한 상태에 접근할 수 있도록 허용.
        Actor는 또한 class와 달리 상속을 지원하지 않음 -> Actor를 통해 보다 안전하고 예측 가능한 동시성 프로그래밍을 위함.
        */
    }
}

class ClassCounter {
    var count: Int = 0
    
    func increment() -> Int {
        Thread.sleep(forTimeInterval: 1)
        count += 1
        return count
    }
}

actor ActorCounter {
    var count: Int = 0
    
    func increment() -> Int {
        Thread.sleep(forTimeInterval: 1)
        count += 1
        return count
    }
}
