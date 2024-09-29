## 🎨 Clean Swift를 사용한 원하는만큼 Unsplash 이미지를 가져오는 프로젝트

이전에 만들어둔 Example에 대한 설명은 각 브랜치에서 확인할 수 있습니다.
- [MVP](https://github.com/YoonAh-dev/ImageExample_Pattern/tree/mvp)
- [MVVM Example - RxSwift](https://github.com/YoonAh-dev/ImageExample_Pattern/tree/mvvm/rxswift)
- [MVVM Example - Combine](https://github.com/YoonAh-dev/ImageExample_Pattern/tree/mvvm/combine)
- [MVVM Example - Input/Output](https://github.com/YoonAh-dev/ImageExample_Pattern/tree/mvvm/input-output)



<br>

### ⓵ ImageExample - 메인 화면 동작 Gif

| ![Simulator Screen Recording - iPhone 14 Pro - 2023-04-11 at 23 01 20](https://user-images.githubusercontent.com/55099365/231187546-37ef9c94-603c-4f1f-bfdd-50db1f920be9.gif)|
|--|
|1. 하단에 있는 < > 버튼을 이용해서 가져오고 싶은 이미지의 갯수를 정합니다.(최소 1장, 최대 30장)<br>2. 이미지 갯수를 정하고 `이미지 가져오기` 버튼을 누르면 Unsplash 에서 이미지를 가져옵니다.<br>3. 가져온 이미지는 CollectionView를 사용해서 볼 수 있습니다.<br>4. ColletionView를 스크롤하면 다음 이미지를 볼 수 있고, PageControl가 움직입니다.<br>5. 각 이미지를 클릭하면 상세 페이지로 이동합니다.|

<br>

### ⓶ ImageExample - 상세 화면 동작 Gif

| |
|--|
|1. < 버튼을 누르면 이전 화면으로 이동합니다. <br>2. 상단 Edit 버튼을 누르면 반모달이 노출됩니다.<br>3. 반모달에서 제목을 변경하고 저장을 누르면 해당 이름으로 제목이 저장됩니다. <br>4. 저장된 이름은 첫 번째 화면에 노출됩니다.|

<br>

### ⓷ Clean Swift 란?

Clean Swift를 프로젝트에 적용했습니다.

Clean Swift는 

Clean Swift에 대한 더 자세한 내용은 [해당 포스팅]()에서 확인하실 수 있습니다.

<br>

### ⓸ 프로젝트에서 Clean Swift를 어떻게 적용했는가?

<img width="1040" alt="스크린샷 2023-04-11 오후 11 12 57" src="https://github.com/YoonAh-dev/ImageExample_Pattern/assets/55099365/84b6eda2-3098-4196-b1c7-16dd78b2ec65">

* `Service`라는 클래스를 만들어서 Model에 관련한 로직을 다루도록 했습니다.
* `Service` 클래스는 ViewModel이 소유하고 있습니다.
* ViewController(View)는 ViewModel를 소유하고 있습니다.