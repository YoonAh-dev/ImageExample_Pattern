## 🎨 MVP 패턴을 사용한 원하는만큼 Unsplash 이미지를 가져오는 프로젝트

[MVP 패턴](https://yoonah-dev.oopy.io/25e43b61-61e1-4972-b590-6a8eb52fea31)에서 제가 정리해둔 MVP 패턴에 대한 정보를 보실 수 있습니다. 잘못된 부분이 있다면 언제든 노션 블로그 채널톡으로 연락주세요.🙇‍♂️

<br>

### ⓵ ImageExample 동작 Gif

| ![Simulator Screen Recording - iPhone 14 Pro - 2023-04-11 at 23 01 20](https://user-images.githubusercontent.com/55099365/231187546-37ef9c94-603c-4f1f-bfdd-50db1f920be9.gif)|
|--|
|1. 하단에 있는 < > 버튼을 이용해서 가져오고 싶은 이미지의 갯수를 정합니다.(최소 1장, 최대 30장)<br>2. 이미지 갯수를 정하고 `이미지 가져오기` 버튼을 누르면 Unsplash 에서 이미지를 가져옵니다.<br>3. 가져온 이미지는 CollectionView를 사용해서 볼 수 있습니다.<br>4. ColletionView를 스크롤하면 다음 이미지를 볼 수 있고, PageControl가 움직입니다.|

<br>

### ⓶ 프로젝트에서 MVP를 어떻게 분리했는가?

<img width="1040" alt="스크린샷 2023-04-11 오후 11 12 57" src="https://user-images.githubusercontent.com/55099365/231190640-5711338f-1359-499f-82f3-328b0b3bdb7b.png">

* `Service`라는 클래스를 만들어서 Model에 관련한 로직을 다루도록 했습니다.
* `Service` 클래스는 Presenter가 소유하고 있습니다.
* `View Interface`를 만들어서 Presenter가 Delegate를 통해서 UI Update를 진행하도록 했습니다.
* `Interface`로 인해서 Presenter와 View는 느슨하게 연결되어 있습니다.
* ViewController(View)는 Presenter를 소유하고 있습니다.

<br>

### ⓷ Testable MVP
테스트 클래스 `ImageExample_MVPTests`에서 Presenter 내부에 메서드들을 테스트했습니다. Presenter가 제대로 Value를 바꿨는지를 확인하기 위해서 MockView를 생성하여 테스트를 진행했습니다.

```swift
@testable import ImageExample_MVP

final class ViewController_Mock: ViewControllerDelegate {

    // MARK: - property

    var count: Int?
    var urls: [String]?
    var currentPage: Int?

    // MARK: - func

    func displayCount(_ count: Int) {
        self.count = count
    }

    func displayImages(imageURLs: [String]) {
        self.urls = imageURLs
    }

    func changePageControl(currentPage: Int) {
        self.currentPage = currentPage
    }
}
```

* displayCount 메서드에서 count를 적절하게 변경했는지 확인했습니다.
* changePageControl 메서드에서 width, offsetX에 맞게끔 currentPage가 바뀌었는지 확인했습니다.

<br>

#### ☑️ Count 관련 Test
```swift
func test_increaseCount_countValue가_제대로_설정이_되는가() {
    self.sut?.increaseCount()
    XCTAssertEqual(2, self.mockView?.count)
}

func test_decreaseCount_count가_1일때_countValue가_제대로_설정이_되는가() {
    self.sut?.decreaseCount()
    XCTAssertEqual(nil, self.mockView?.count)
}
```

#### ☑️ CurrentPage 관련 Test
```swift
func test_currentPage가_제대로_설정이_되는가() {
    let width: Double = 100
    let offset: Double = 400
    self.sut?.changeCurrentPage(with: width, offset)
    XCTAssertEqual(4, self.mockView?.currentPage)
}
```
