# Modoo

[![Swift Version][swift-image]][swift-url]
![Build Status][github-action-image]
[![codecov][codecov-image]][codecov-url]
[![License][license-image]][license-url]

## Welcome

해당 프로젝트는 인스타그램의 클론 앱니다.

## 필수 사항

- iOS13.0 +
- Xcode12.4 +

## 인스톨 방법

- 해당 프로젝트는 [XCodeGenerator][xcodegen-url]로 프로젝트 파일을 생성합니다.
- 인스톨은 shell script로 간편하게 할 수 있습니다.

```shell
$ brew bundle --file=./Brewfile
$ make project
```

## 사용 라이브러리

- RIBs: Rx6.0.0이 업데이트 되지 않아, fork 떠서 추가하게 되었습니다.

[swift-url]: https://swift.org/
[swift-image]:https://img.shields.io/badge/swift-5.3-orange.svg
[github-action-image]: https://github.com/interactord/Modoo/workflows/CI/badge.svg
[codecov-image]: https://codecov.io/gh/interactord/Modoo/branch/master/graph/badge.svg
[codecov-url]: https://codecov.io/gh/interactord/Modoo
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE

[xcodegen-url]: https://github.com/yonaskolb/XcodeGen
