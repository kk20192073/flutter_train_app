# 🚄 flutter_train_app

Flutter로 제작한 기차 예매 애플리케이션입니다. 사용자는 출발역과 도착역을 선택하고, 좌석을 선택하여 예매할 수 있습니다.

---

## 📱 주요 기능

- 출발역과 도착역 선택 기능
- A, B, C, D 열과 1번부터 20번까지의 좌석으로 구성된 총 120석 선택 UI
- 선택된 좌석으로 예매 처리 및 확인
- 반응형 UI 구성
- 간단한 Navigator 기반 페이지 전환
- 다크모드 추가(토글 버튼)
- 다음에 고르는 페이지애서 이미 선택 역을 제와한 목록 보여주기 

---

## 🧩 주요 화면 구성

- `HomePage.dart` : 출발역/도착역 선택, 좌석 선택 진입
- `StationListPage.dart` : 역 목록 리스트에서 선택
- `SeatPage.dart` : 좌석을 시각적으로 선택하고 예매하는 화면

---

## 🛠️ 실행 방법

```bash
# Flutter 환경 준비가 필요합니다.
# 1. 의존성 설치
flutter pub get

# 2. 앱 실행
flutter run
