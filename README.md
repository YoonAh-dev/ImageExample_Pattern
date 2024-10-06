## 🎨 Clean Swift를 사용한 원하는만큼 Unsplash 이미지를 가져오는 프로젝트

이전에 만들어둔 Example에 대한 설명은 각 브랜치에서 확인할 수 있습니다.
- [MVP](https://github.com/YoonAh-dev/ImageExample_Pattern/tree/mvp)
- [MVVM Example - RxSwift](https://github.com/YoonAh-dev/ImageExample_Pattern/tree/mvvm/rxswift)
- [MVVM Example - Combine](https://github.com/YoonAh-dev/ImageExample_Pattern/tree/mvvm/combine)
- [MVVM Example - Input/Output](https://github.com/YoonAh-dev/ImageExample_Pattern/tree/mvvm/input-output)



<br>

### ⓵ ImageExample - 메인 화면 동작 Gif

|  |
|--|
|1. < > 버튼을 이용해서 가져오고 싶은 이미지의 갯수를 정할 수 있습니다.(최소 1장, 최대 30장)<br>2. `이미지 가져오기` 버튼을 누르면 Unsplash API를 통해서 이미지를 가져옵니다.<br>3. 가져온 이미지는 CollectionView에서 볼 수 있습니다.<br>4. ColletionView를 스크롤하면 다음 이미지를 볼 수 있고, PageControl가 움직입니다.<br>5. 각 이미지를 클릭하면 상세 페이지로 이동합니다.|

<br>

### ⓶ ImageExample - 상세 화면 동작 Gif

| |
|--|
|1. 이전 화면에서 선택한 사진을 노출합니다.<br>2. 상단 Edit 버튼을 누르면 Index를 변경할 수 있는 반모달이 노출됩니다.<br>3. 반모달 화면에서 Index를 변경하고 저장 버튼을 누르면 Index가 저장됩니다.<br>4. 이전 화면으로 돌아가면 변경된 Index로 사진 순서가 변경됩니다.|

<br>

### ⓷ Clean Swift 란?

저자가 Clean Swift의 장점을 48페이지 내내 장황하게 늘어놓지만, 간단히 정리하면:
> Clean Swift가 제공하는 boiler plate만을 사용해서 누구나 작성하기 쉽고, 이해하기 쉽고, 유지보수하기 좋은 코드를 작성할 수 있습니다.

Clean Swift는 **Clean Architecture**에서 유래되었다고 저자는 말합니다.

클린 아키텍처는 App Level의 UseCase를 더 작은 코드 수준의 UseCase로 분해하여 적절한 레이어로 분리합니다. 그로 인해 각 레이어의 관심사가 분리(Separation of Concerns)됩니다.
즉, 각 코드가 관심사에 맞춘 레이어에 위치하게 됩니다.

<br>

Clean Swift는 클린 아키텍처의 레이어에 **VIP Cycle를 추가**합니다.
VIP Cycle은 Clean Swift의 핵심 개념으로 ViewController - Interactor - Presenter를 의미합니다.

해당 Cycle은 ViewController로부터 시작됩니다.

ViewController에서 발생한 이벤트가 Interactor를 호출하고, Interactor는 Presenter를 호출하게 됩니다. 마지막으로 Presenter가 ViewController를 호출하면서 Cycle은 끝나게 됩니다.

ViewController → Interactor → Presenter → ViewController 순서로 흐르기 때문에 단방향으로 흐름이 흘러가게 됩니다.


Clean Swift에 대한 더 자세한 내용은 [해당 포스팅](https://yoonah-dev.oopy.io/08ece7c3-715c-4407-a397-5859301a41ae)에서 확인하실 수 있습니다.

<br>

### ⓸ 프로젝트에서 Clean Swift를 어떻게 적용했는가?

- [Clean Swift 적용해보기(1) - 메인 화면 만들어보기](https://yoonah-dev.oopy.io/1104fe45-ab9a-8010-84d4-fd5dac2e28f2)
- [Clean Swift 적용해보기(2) - 상세 화면 만들어보기](https://yoonah-dev.oopy.io/1124fe45-ab9a-80c4-a4af-e65e41b2eb9c)
- [Clean Swift 적용해보기(3) - 이전 화면으로 값 전달하기](https://yoonah-dev.oopy.io/1144fe45-ab9a-8019-972c-d6ee4622db95)
