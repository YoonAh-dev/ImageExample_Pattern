## 🎨 MVVM 패턴을 사용한 원하는만큼 Unsplash 이미지를 가져오는 프로젝트

이전에 만들어둔 [MVP Example](https://github.com/YoonAh-dev/ImageExample_Pattern/tree/mvp)에 대한 설명은 `mvp` 브랜치에서 확인할 수 있습니다.

[MVVM 패턴](https://yoonah-dev.oopy.io/9ce987de-36b7-476e-9744-66077124b379)에서 제가 정리해둔 MVVM 패턴에 대한 정보를 보실 수 있습니다. 잘못된 부분이 있다면 언제든 노션 블로그 채널톡으로 연락주세요.🙇‍♂️

<br>

### ⓵ ImageExample 동작 Gif

| ![Simulator Screen Recording - iPhone 14 Pro - 2023-04-11 at 23 01 20](https://user-images.githubusercontent.com/55099365/231187546-37ef9c94-603c-4f1f-bfdd-50db1f920be9.gif)|
|--|
|1. 하단에 있는 < > 버튼을 이용해서 가져오고 싶은 이미지의 갯수를 정합니다.(최소 1장, 최대 30장)<br>2. 이미지 갯수를 정하고 `이미지 가져오기` 버튼을 누르면 Unsplash 에서 이미지를 가져옵니다.<br>3. 가져온 이미지는 CollectionView를 사용해서 볼 수 있습니다.<br>4. ColletionView를 스크롤하면 다음 이미지를 볼 수 있고, PageControl가 움직입니다.|

<br>

### ⓶ 프로젝트에서 MVVM를 어떻게 분리했는가?

<img width="1040" alt="스크린샷 2023-04-11 오후 11 12 57" src="https://github.com/YoonAh-dev/ImageExample_Pattern/assets/55099365/84b6eda2-3098-4196-b1c7-16dd78b2ec65">

* `Service`라는 클래스를 만들어서 Model에 관련한 로직을 다루도록 했습니다.
* `Service` 클래스는 ViewModel이 소유하고 있습니다.
* ViewController(View)는 ViewModel를 소유하고 있습니다.

<br>

### ⓷ RxSwift

ImageExample_MVVM_RxSwift에서는 RxSwift를 사용해서 바인딩을 진행했습니다.

RxSwift로 코드를 구성한 방식은 [해당 포스팅](https://yoonah-dev.oopy.io/e36f5e35-7872-40ba-9a7b-319a9f597e2a)에서 확인하실 수 있습니다.

`mvvm/rxswift` 브랜치에는 ViewController에서 ViewModel의 메서드 호출을 통해서 유저 액션을 보내고, ViewModel에 있는 Relay로부터 들어오는 데이터를 받아서 UI를 업데이트합니다.

`main`, `mvvm/input-output` 브랜치에는 ViewController가 ViewModel에 있는 Iuput 구조체로 유저 액션을 스트림 형태로 보내고 ViewModel에 있는 Output 구조체를 통해서 Relay로부터 들어오는 데이터를 받아서 UI를 업데이트 합니다.

<br>

### ⓸ Combine

ImageExample_MVVM_Combine에서는 Combine를 사용해서 바인딩을 진행했습니다.

Combine으로 코드를 구성한 방식은 [해당 포스팅](https://yoonah-dev.oopy.io/3b140db6-be28-43b6-952c-e16b16b0bb2d)에서 확인하실 수 있습니다.

`mvvm/combine` 브랜치에는 ViewController에서 ViewModel의 메서드 호출을 통해서 유저 액션을 보내고, ViewModel에 있는 Subject, Publisher로부터 들어오는 데이터를 받아서 UI를 업데이트합니다.

`main`, `mvvm/input-output` 브랜치에는 ViewController가 ViewModel에 있는 Iuput 구조체로 유저 액션을 스트림 형태로 보내고 ViewModel에 있는 Output 구조체를 통해서 Subject로부터 들어오는 데이터를 받아서 UI를 업데이트 합니다.
