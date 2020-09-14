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