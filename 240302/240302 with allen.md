# 복습1

### 프로그래밍 관련 용어 정리 (12강)

- 리터럴 : 하나의 값으로 표현되는 데이터 그 자체
- 표현식 : 하나의 결과값으로 표현되는 코드 단위
- 문장 : 특정 작업을 실행하는 코드 단위

### 프로그래밍의 기본원리와 if 조건문 (15강)

- 프로그래밍의 기본원리
    - 순차 ∙ 조건 ∙반복

### 조건문 (switch문) (16강)

- **case 뒤의 값 자리에 콤마(,)로 여러 조건을 줄 수 있다 → ||(or) 의 의미**
- 모든 케이스를 커버하지 못하는 경우에는 default 를 써줘야 한다
    - **아무것도 안 할거면 break 를 써줘야 한다**
- fallthrough 는 값에 관계 없이 다음 문장도 실행시켜준다
- **부등식 사용할 수 없고 → 범위 연산자 사용해야 한다**

### switch문의 활용 (17강)

```swift
var score : Int = 50
switch score {
// % 가 == 보다 우선순위가 높다
case let x where x % 2 == 0 :
    print("짝수 입니다")
default :
    print("홀수 입니다")
}
```

### 튜플 기본 (19강) , 튜플의 활용 (20강)

튜플 : **연관된 데이터의 조합**으로 어떤 형태든 만들 수 있는 타입 

- 여러 타입을 섞어서 사용 가능
- 추가 / 삭제는 불가
- 구조체랑 비슷하지만, 데이터구조가 임시범위를 넘어서 존속할 가능성이 있으면 구조체를 사용해라

```swift
// 선언
var brown1 = ("브라운", 30, "포항")

// 값 접근
brown1.0

// 네임드 튜플
var brown2 = (name : "브라운", age: 30, location : "포항")
brown2.name

// 바인딩이 가능해요 -> 오 이거 신기하다
let(name, age, location) = ("브라운", 30, "포항")
print(name)

// 튜플과 switch 바인딩 콜라보
switch brown3 {
case let(x,y):
    print("이름 : \(x) , 나이 : \(y)")
default:
    break
}
```

### 범위연산자 / 패턴매칭 연산자 (22강)

특정한 조건에서만 사용해

- switch 문에서 패턴 매칭
- for 문
- 배열의 서브스크립트?

패턴매칭연산자

```swift
if n >= 10 && n <= 100 {
    print("10이상, 100이하입니다.")
}

if 10...100 ~= n {
    print("10이상, 100이하입니다.")
}
```

### 함수의 기본 개념 (28강)

정의 : 파라미터 , 매개변수 , 인자

실행 : 아규먼트 , 인수

### 함수의 응용 - 파라미터, 아규먼트 커스텀 (29강)

가변 파라미터 : 정해지지 않은 여러개의 파라미터를 받을 때 → 배열 형태로 전달

```swift
func averageMaker(_ numbers : Double...) {
    var total = 0.0
    for i in numbers {
        total += i
    }
}
```

### 함수 사용시 주의점 (30강)

함수의 실행문 : 함수를 호출하는 것은 그 자체로 표현식이다 → 값처럼 쓰면 됨

### 함수 실행의 메모리 구조 - 1 (35강)

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

- main 스택프레임
    - num1 공간 만들고 저장
    - num2 공간 만들고 저장
    - num3 공간만들기
- addTwoNumbers 스택프레임 만들고
    - 복귀 주소 저장
    - a 공간에 저장
    - b 공간에 저장
    - c 공간에 저장
    - 스택프레임 사라지며 num3에 c 값 저장
- print 스택프레임 생성 → print → 스택프레임 제거
- main 스택프레임 제거

### 입출력(inout) 파라미터 (38강)

```swift
func inoutTest(a: **inout** Int, b: **inout** Int){
    a *= 2
    b *= 2
}

inoutTest(a: **&**a, b: **&**b)
```

### 옵셔널 타입의 기본 개념 (43강)

```swift
enum Optional {
    case some(Int)
    case none
}

var num : Optional = Optional.some(7)
var nil : Optional = Optional.none

switch num {
case .some(let a) :
    print(a)
case .none :
    print("nil")
}
```

- Optional 은 Enum 타입
    - 그러니 값이 없어도 에러가 안남
- 값이 없으면 .none 케이스이고, 값이 있으면 .some(Int) 가 된다
- Enum 연관값을 꺼내려면 패턴매칭 바인딩을 사용하는데 Swift 는 If let 바인딩으로 이를 사용할 수 있도록 구현해놓았다

### 옵셔널 타입의 응용 (45강)

- 옵셔널 체이닝 : 옵셔널 타입에 선언된 값에 접근해서 속성, 메서드를 사용할 때 접근 연산자(.) 앞에 물음표를 붙여야 함
    - 항상 옵셔널 타입으로 리턴
- 함수 관련 표기
    
    ```swift
    var name = cat?.myMaster?()?.name
    ```
    
    - myMaster 뒤의 물음표 → 함수가 없을 수도 있다
    - myMaster?( ) 뒤의 물음표 → 함수의 결과값이 없을 수도 있다

### 스위프트 컬렉션의 기본 개념 / 배열 (46강)

컬렉션

- **데이터를 효율적으로 관리하기 위한 자료형 → 바구니**
- 배열 : 데이터 순서대로 저장
- 딕셔너리 : 키와 값 하나의 쌍으로 만들고, 순서가 없다
- 세트 : 순서가 없는 집합

enumerated

```swift
var nums = [10, 11, 12, 13, 14]

for tuple in nums.enumerated() {
    print(tuple)
}

// (offset: 0, element: 10)
```

### 딕셔너리 / 해셔블(Hashable) (49강)

- 딕셔너리
    
    ```swift
    // 정석
    var dic : Dictionary<String, String> = ["A": "Apple", "B": "Banana", "C": "City"]
    // 단축 문법
    var dic : [String: String] = ["A": "Apple", "B": "Banana", "C": "City"]
    // 빈 사전 생성
    let emptyDic1: Dictionary<Int, String> = [:]
    let emptyDic2 = Dictionary<Int, String>()
    ```
    
    - 키값은 중복 불가능
    - 타입을 잘 지켜야 하고
    - **키값은 Hashable 해야함**
- Hashable
    - Hash 함수의 Input 값으로 사용할 수 있다
    - Hash 함수 → Input 값을 고유한 Hash값으로 바꾸어준다
    - 검색 속도가 빠르다
- 반복문과 결합
    
    ```swift
    //배열에서 뽑을 때 named tuple 형태로
    for (key, value) in dict {
        print("\(key): \(value)")
    }
    ```
    

### 집합(Set) (51강)

- 기본형태
    
    ```swift
    var set: Set<Int> = [1, 1, 2, 2, 3, 3, 3]
    ```
    
    - 배열과 구분이 안되기에, 생성시 타입 선언을 해야함

### 스위프트의 컬렉션 관련 이론 (52강)

Swift Naming Guide

- 동사원형 : 컬렉션을 직접 변경
- 분사 : 변경한 새 컬렉션을 반환

Copy-On-Write 최적화

- 새로운 컬렉션에 값을 복사해서 담아도, 실제 값이 바뀌기 전까지는 하나의 메모리 값을 공유해서 사용
    - 메모리 절약

### iOS Architecture / Framework (70강)

누가 누구를 컨트롤 하는가?

- 라이브러리 : 내가 필요할 때 소환, 쉽게 대체됨, 레고 세트 내에서 만들 때 편하라고 몇개 붙여 놓은 것
- 프레임워크 : 프레임워크가 나를 부른다, 프레임워크가 시키는 룰을 따라야 함, 레고 세트 자체(레고의 끼우기 룰을 따라야 한다)
