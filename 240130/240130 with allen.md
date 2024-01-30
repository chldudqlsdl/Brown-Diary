# 함수 실행의 메모리 구조 - 1 (35강)

### main( )

우리는 main 함수에 코드를 작성하는 것이고, 앱을 실행하면 이 main 함수를 실행시킨다

### 작동원리

```swift
func addTwoNumbers(a: Int, b: Int) -> Int {
    var c = a + b
    return c
}

var num1 = 5   
var num2 = 3    
var num3 = addTwoNumbers(a: num1, b: num2)

print(num3)
```

- 이 코드는 CPU가 알아들을 수 있게 컴파일되고 CPU는 이를 한줄 한줄 실행한다
- 스택(선입후출) : **함수실행시** **스택에 필요한 공간(스택 프레임)을 만들고, 함수 실행완료되면 공간 사라짐**
    - main( ) 스택프레임 만들고
        - num1, num2 메모리 공간 만들고 리터럴 할당
        - num3 메모리 공간만든다
    - addTwoNumbers( ) 스택프레임 만들고
        - 함수 종료되면 어디로 돌아가야할지 알기위해 `addTwoNumbers(a: num1, b: num2)` **명령어의 주소(복귀주소)를 기억시킨다(메모리 공간을 만든다)**
        - 이 함수는 **리턴 타입이 있기에, 리턴값(임시값)이 들어갈 메모리 공간을 만든다**
        - let a 메모리 공간에 5 할당, let b 메모리 공간에 3 할당, var c 메모리 공간에 8 할당
        - c 의 값이 임시값 공간에 저장이 된다
        - 스택프레임이 사라지면서 임시값이 반환되어 num3 공간에 들어간다
    - main( )
        - num3 공간에 8이 저장되고
    - print( ) 스택프레임 만들고
        - 종료되면 돌아갈 복귀주소를 메모리 공간에 저장
        - 8을 저장할 메모리 공간을 만들어 사용하고 프린트
        - 스택프레임 사라짐
    - main( )
        - 스택프레임 사라짐
    
    ### 코데힙스
    
    - 전역변수는 데이터에 저장됩니다
    - 스택에서는 데힙에 언제든지 접근이 가능합니다
    
# 입출력(inout) 파라미터 (38강)

### 기존에는 파라미터에 인수의 복사본이 전달된다

### 참조값(메모리주소)를 전달하면 함수에서 (파라미터에 들어온) 인수 값을 변경할 수 있다

```swift
var a = 5
var b = 10

// inout 을 작성 안 하면 a 는 상수이므로 아래처럼 값을 변경하지도 못함!
func inoutTest(a: **inout** Int, b: **inout** Int){
    a *= 2
    b *= 2
}

inoutTest(a: **&**a, b: **&**b)

print(a, b)
```

- **파라미터 타입 앞에 `inout` 작성해주기**
- **함수호출할 때 인수앞에 `&` 붙여주기**

inout → 넣었다가 뺀다고 생각하믄 댐

# guard문 (39강)

### 기본형태

```swift
var myMoney : Int = 1000

func guardTask(enterYourMoney money: Int) {
    guard money > 10000 else {return}
    print("welcome")
}

guardTask(enterYourMoney: myMoney)
```

- guard → 감시하다

### 왜 사용하나요?

1. 가독성 → if문은 계속 들여써야하자나
2. 옵셔널 타입 벗기기
    1. guard 문에서 선언된 변수 아래 문장에서 사용가능

### 함수나 반복문 내부에서만 사용가능하다?

guard body 에서 빠져나오려면 **return, throw, break, continue** 얘네를 사용해야만 나올 수 있다!

→ 그러면 함수나 반복문 내부에서만 거의? 사용가능한거잖아???

# 함수의 리턴값과 @discardableResult (40강)

### 기본형태

```swift
func myfunc() -> String {
    return "브라운"
}

// 리턴 값이 있는 함수의 리턴값을 사용하지 않으면 경고가 뜬다
myfunc()

// 그래서 이렇게 사용하는데
_ = myfunc()

**// 이렇게 사용하면 된다는 것
@discardableResult
func myfunc() -> String {
    return "브라운"
}**
```

### @어트리뷰트 키워드

어트리뷰트 == 속성 

언제 사용하는지요? → 추가 속성을 제공하고 싶을 때

- **선언에 추가적인 정보**
    - @available
- **타입에 추가적인 정보**
    - @escaping
