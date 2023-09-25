# 1. Nomad Study Final Project: 🔥 Mood Tracker 🔥

## 1.1. [Outline](#Outline)

- 이 프로젝트는 기분 추적기 앱입니다.
- Firebase 인증과 Firestore, Riverpod, GoRouter 및 MVVM을 사용합니다.
- 그외에는 자유?

## 1.2. [Essential](#Essential)

### 1.2.1. [Authentication](#Authentication)

- [SignUp](#SignUp)
  - [ ] 가입 및 로그인 화면에는 이메일과 비밀번호의 두 가지 입력이 있는 양식이 있어야 합니다.
  - [ ] 사용자가 계정을 만들 때 Firebase에서 계정이 생성되고 Firebase 인증을 사용하여 로그인해야 합니다.
- [SignIn](#SignIn)
  - [ ] 사용자가 로그인하면 Firebase 인증을 사용하여 가입하고 홈 화면으로 이동해야 합니다.
- [SignOut](#SignOut)
  - [ ] 사용자가 로그아웃하면 홈으로 이동

### 1.2.2. [Crud](#Crud)

#### 1.2.2.1. [HomeScreen](#HomeScreen)

- [ ] 홈 화면에는 두 개의 탭이 있는 탐색 표시줄이 있어야 합니다: "홈" 및 "게시물"
- [ ] 사용자가 "게시물" 탭을 누르면 게시물 화면으로 이동해야 합니다.
- [ ] 사용자가 "홈" 탭을 누르면 홈 화면으로 이동해야 합니다.
- [ ] 무드 항목은 Firestore에서 로드해야 합니다.
- [ ] 무드 항목에는 날짜, 무드(이모티콘) 및 설명이 있어야 합니다.
- [ ] 무드 항목을 길게 누르면 사용자에게 무드 항목을 삭제할 것인지 묻는 경고 대화 상자가 표시되어야 합니다.
- [ ] 사용자가 "삭제"를 누르면 무드 항목이 Firestore에서 삭제되어야 합니다.

#### 1.2.2.2. [PostScreen](#PostScreen)

- [ ] 포스트 화면에는 무드 항목에 대한 설명을 작성하는 입력란이 있어야 합니다.
- [ ] 입력란 아래에는 이모티콘이 있는 버튼 목록이 있어야 합니다.
- [ ] "게시" 버튼을 누르면 Firestore에 무드 항목이 생성되고 사용자는 새 무드 항목이 표시되어야 하는 홈 화면으로 이동해야 합니다.
