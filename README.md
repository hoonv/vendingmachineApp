# swift-w3-vendingmachine



# 1일차 PR

<img width="600" alt="스크린샷 2020-09-15 오전 12 16 01" src="https://user-images.githubusercontent.com/46335714/93104314-a50a9080-f6e8-11ea-88fd-91e6dba32187.png">
<img width="600" alt="스크린샷 2020-09-15 오전 12 16 14" src="https://user-images.githubusercontent.com/46335714/93104341-acca3500-f6e8-11ea-80d3-948d77c11ec6.png">

각각의 init에 break point를 걸어서 po sefl를 통해 print 없이 객체의 정보를 출력했다.



![스크린샷 2020-09-14 오후 11.16.29](/Users/chae/Desktop/스크린샷 2020-09-14 오후 11.16.29.png)

beverage의 class diagram



## feature

- 음료의 최상위 클래스 Beverage
- Beverage의 하위 클래스 Milk Coffee Soda
- Milk의 하위 클래스 Choco, StrawBerry
- Coffee의 하위 클래스 Cantata, Georgia
- Soda의 하위 클래스 Coke Cider
- 각각의 클래스들은 프로토콜을 채택하는데 프로토콜의 종류는 (sugar, calorie, caffeine, milk)

## thinking

- 자판기는 두개의 액터가 존재한다. 관리자와 구매자, 일단 프로토콜로 분리했지만 그 두개의 프로토콜을 다 채택한다면 SRP에 어긋나는것인지.. 🤔

## Question

- Sugar caffeine 프로토콜 부분에 extention으로 default implement를 넣어놨는데 그 이유는 코드가 너무 중복이 되서 넣어놨는데 확실히 디폴트로 잡아두니 새로운 객체가 프로토콜을 채택한다고 할때 isHigh isLow의 존재를 인식 못할 것 같다고 생각했습니당.. 코드의 중복을 감수하더라도 default를 제거할까욤.. 아니면 주석을 달아서 quick help를 이용하는식으로 할까요.. ( 자문자답해보자면 현업에서는 default를 사용하지 않을 것 같습니다 .. ㅎㅎ 질문을 다시 하자면 default implement 부분을 그냥 냅둬도 될까요? ㅎㅎ;; 현재는 음료마다 통일 될것 같긴 합니다 ! 거의 허락을 구하는거 같네요 ㅎㅎ;; )



# 2일차 PR

## Demo 
![vending](https://user-images.githubusercontent.com/46335714/93216987-5e2da100-f7a3-11ea-9566-0eb01c14dfbf.gif)

## feature
- 자판기 구조체 구현 ( Manageable, Salable ) 두개의 프로토콜을 채택해서 관리자 인터페이스와 구매자 인터페이스를 따로 두었음
- Beverage Line 클래스 구현 자판기의 음료수 한줄 한줄을 의미함
- Beverage Factory 음료수를 만드는 클래스 구현
- 스토리보드를 통한 UI 구현 

## thinking
- 하나하나 손수 스토리보드에 View 추가하며 오토레이아웃 주면서 진행했습니다. 저 음료수와 추가 구매 버튼들을 하나의 View로 합칠 수 있을 것 같긴 한데 일단 노가다로 다 끌어나가 연결하면서 진행했습니다.. ㅠㅠ
- 확실히 뷰를 나누지 않으니 뷰컨트롤러가 거대해졌습니다. 뷰컨트롤러 안에서 itemToIdx 와 idxToItem을 통해 label의 텍스트나 button의 이벤트가 발생했을때 어떤 음료가 타겟인지 알기 위해 선언했는데 뭔가 명쾌하진 않은거 같습니다. 모델의 기능이 부족해서 뷰컨트롤러에서 일이 많아진건지 내일 다시 확인해봐야겠습니다.


## question

``` swift
    private func classifyNameToImage(item: Beverage) -> UIImage? {
        switch item {
        case _ as Coke:
            return UIImage(named: "coke.png")
        case _ as Cider:
            return UIImage(named: "cider.png")
        case _ as StrawberryMilk:
            return UIImage(named: "strawberry.png")
        case _ as ChocoMilk:
            return UIImage(named: "choco.png")
        case _ as Cantata:
            return UIImage(named: "cantata.png")
        case _ as Georgia:
            return UIImage(named: "georgia.png")
        default:
            return UIImage(named: "")
        }
    }
```
클래스에 맞는 이미지를 리턴 하는 함수인데 좋은 방법이 떠오르지 않습니다 ㅎㅎ; 모델에서 image의 이름을 갖고 있는 방식이 좋을까요? 





# 3일차 PR

## feature
- 자판기 구조체에 대해 다시 설계했습니다.
 ``` swift
struct VendingMachine {
    
    private let manager: ProductManager
    private let balance: Balance
    ...
 ```
기존에 많은 일을 하던 자판기에서 가상의 manager를 두어 상품에 관한 일들을 처리하게 시킴 
```swift
    public func receiveBalance(coin: Int) {
        balance.deposit(amount: coin)
    }
    
    public func receiveBalance(bill: Int) {
        balance.deposit(amount: bill)
    }
```
Coin -> Balance 변경하고 자판기의 역할은 다양한 결제 방법을 지원 coin bill card 등 여러 결제방법으로 진행하고 검증 후 balance의 양을 증가시키는 로직
자판기의 입장에서 금액을 받는다는 메소드로 naming하였습니다.

``` swift
class ProductManager {
    
    private var lines: [ProductLine]
    func addProducts(beverages: [Beverage]) {
    }
    
    func removeProduct(index: Int) {
    }
    
    func receiveOrder(index: Int, amount: Int) -> Beverage? {
    }
```
상품매니저는 상품라인들을 관리하는데 재고 추가 재고 삭제 주문받기 등의 동작이있습니다. 아직은 Beverage의 구체타입이지만 Product라는 프로토콜을 생성 후 Beverage가 이를 채택하여 여러 종류의 상품을 관리하게 해야 할 것 같습니다.



# 4일차 PR



![데이터저장](https://user-images.githubusercontent.com/46335714/93477305-d6c46700-f935-11ea-94eb-68154cafbc09.gif)

![구매1](https://user-images.githubusercontent.com/46335714/93477796-69fd9c80-f936-11ea-94ee-97e162875ecc.gif)

## feature
- Codable을 채택해서 Json으로 encoder후 UserDefault에 자판기 데이터 저장
- Scene Delegate의 자판기를 공유함
- 관리자 페이지 생성해서 제고 관련 기능 담당

## thinking
- Beverage를 아카이빙 하는 과정에서 Codable로 진행하였는데 Decoder할때 Coke가 Beverage로 변환되어서 인식이 안되는 문제가 있었습니다. 구체적인 타입이 필요한 경우가 클래스별로 이미지를 만들때 일단 필요해서 응급처지로 이름으로 만들고있습니다. 알아보니 상속관계에 있는 클래스는 NSObject와 NSCoding ? 으로 아카이빙해야된다는걸 알았습니다. 추후에 수정할 생각입니당..

- scene Delegate의 인스턴스를 가져올떄  
``` swift 
UIApplication.shared.connectedScenes.first!.delegate
```
이렇게 가져왔는데 
`view.window.blah.blah` 로 가져오는 방법도 있는거 같은데 scene간 동기화를 위해 첫번쨰 scene 에서만 가져오게 하려고 위의 방법처럼 했습니다.
하나하나 레이아웃주고 추가하다보니 화면이 스플릿됐을때 반응하지 못한 UI가 되버렸습니다. 차츰차츰 공부하면서 개선해나가야 할것 같습니다



## Question

- Button 에 tag가 있는데 이걸 어떻게 활용하는게 옳은 건지 모르겠습니다 예를들면 +1000원 버튼에 tag값을 1000 +5000원 버튼에 tag값을 5000을 주고 같은 이벤트핸들러를 달아준 다음 태그값을 모델에 넘겨주는방식도 괜찮은지 또 지금 제품이 6개라 버튼이 6갠대 이 버튼의 인덱스를 tag값으로 구분해도 되는지 궁금합니다.





# 2주차



## 1일차

## Demo

<img width="600" alt="스크린샷 2020-09-21 오후 11 47 53" src="https://user-images.githubusercontent.com/46335714/93781916-df35de00-fc64-11ea-9c90-759df79a3def.png">
<img width="600" alt="스크린샷 2020-09-21 오후 11 48 17" src="https://user-images.githubusercontent.com/46335714/93781954-eeb52700-fc64-11ea-92b5-656a9f38ff34.png">
<img width="600" alt="스크린샷 2020-09-21 오후 11 48 34" src="https://user-images.githubusercontent.com/46335714/93781986-f83e8f00-fc64-11ea-8cd6-1300627f018a.png">

<img width="600" alt="스크린샷 2020-09-21 오후 11 52 39" src="https://user-images.githubusercontent.com/46335714/93782443-8a469780-fc65-11ea-8b58-10c873c4eece.png">

## Thinking
- 나머지 부분은 지켜주지 못해 미안하지만.. Collection View 부분을 width Size에 맞게 안의 Cell의 갯수를 조정해서 cell의 크기를 적절하게 유지 하도록 구현했습니다.. 1/2 사이즈나 1/3 사이즈에서 저 현재잔액 부분이 문젠데.. 저 부분을 어떻게 해야할지 😭😭😭
- Collection View로 변환을 해봤는데 그러면서 새롭운 뷰컨트롤러를 도입했는데 그러다 보니 모든 뷰컨트롤러 부분에서 VendingMachine을 갖고있어야 했습니다. scene 델리게이트에서 가져오는데 모두가 그럴 필요가 없을 것 같고 이렇게 가져오는게 좋은 방법이 아닌것 같아.. 고민입니다 뷰컨트롤러를 스토리보드에서 생성하니깐 VC를 init할때 넘겨줄 수가 없는데 이걸 끊고 코드로 생성을 해야하는건지.. 고민입니다
- Beverage 객체를 Codable -> NSOjbect NSCoding을 채택하는것으로 변경했습니다





## 2일차

## Picture
<img width="600" alt="스크린샷 2020-09-22 오후 11 02 27" src="https://user-images.githubusercontent.com/46335714/93892630-b32f6100-fd27-11ea-8aa2-9ef61c8d3364.png">

<img width="600" alt="스크린샷 2020-09-22 오후 11 04 33" src="https://user-images.githubusercontent.com/46335714/93892892-fdb0dd80-fd27-11ea-8020-1adeb1a4e9ec.png">

## Feature
- 챗팅 UI 구현 ( TableView)
- 자연어 처리를 위한 훈련데이터 생성 코드 작성
- 1000가지의 예시 문장 학습


## Question
- 챗팅 UI를 만들면서 입력한 텍스트에 따라 Label이 커지면서 그 바깥에 말풍선 뷰가 커지고 마지막으로 Cell이 커지게 하고 싶은데 너무 어려운거 같습니다 ..ㅠ ㅠ





## 3일차

## picture
<img width="1098" alt="스크린샷 2020-09-24 오전 12 24 24" src="https://user-images.githubusercontent.com/46335714/94033834-505bc980-fdfc-11ea-9b86-97d8b87d628f.png">

## feat
- 글자 수에 따라 말풍선 크기 변경
- 여러줄로 표현 가능 

UI업데이트 후 AVFoundation 에 대해 공부했습니다. 내용이 어려워 작업을 그 부분은 작업을 하지 못했습니당.. 





## 4일차

## Picture

![IMG_0110](https://user-images.githubusercontent.com/46335714/94168537-b3b32d80-fec8-11ea-8e04-5e7bccd47f37.PNG)

![IMG_0111](https://user-images.githubusercontent.com/46335714/94168462-a0a05d80-fec8-11ea-827c-dfb986b196c4.PNG)

![IMG_D1F911606AF7-1](https://user-images.githubusercontent.com/46335714/94169028-3b993780-fec9-11ea-89bd-3c992e6aa0ce.jpeg)

## Feature
- 기기의 방향에 따라 카메라 방향도 움직입니다.
- 화면을 실시간으로 인식해 가장 높은 확률의 물체를 찾아 표시해줍니다.
- 사진을 찍으면 조그만하게 프리뷰를 보여줍니다.


## Thinking
- 직접 만든 모델이 아니라 애플에서 제공해주는 모델로 테스트를 해봤습니다. 나중에 지폐를 학습시켜 인식하게 한다하면 100퍼센트가 되었을때 사진이 찍히도록 구현해야 할것 같습니다. shouldTakePicture을 true 로 바뀌면 바로 캡쳐 되고 파일 저장 후 dismiss하는 순서로?..

- 기기가 회전함에 따라 프리뷰도 회전 해야하는 것에서 좀 어려움이 있었습니다. 지금 기기를 판단하는 로직이 2개인데 좀더 공부해서 하나로 합치던지 해야 할 것 같습니다.

- layer에 대해 공부하는 시간이 되었습니다. 뷰 자체도 레이어로 이루어진다는것을 알았습니다.