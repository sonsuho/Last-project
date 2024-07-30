# 📖 학원 시스템 sist

- 배포 URL : http://3.36.77.227:8080/ex-1.0.0-BUILD-SNAPSHOT/login.in
- Test ID : admin, manager1-7, teacher1-7, student1-7 
- Test PW : 1234

<br>

## 프로젝트 소개

- sist는 학원에서 일어나는 모든 작업을 시스템화하여 학원 내 구성원들 모두에게 편의성을 제공해줍니다.
- 관리자는 학원에 근무하는 매니저와 강사를 총괄할 수 있습니다. 또한 관리자는 강좌를 개설하거나 지울 수 있습니다.
- 매니저는 서류 처리, 학생 관리, 클래스 관리 등 자신이 맡은 반에 대한 총 관리 업무를 할 수 있습니다. 또한 근퇴 시스템을 통해 출퇴근 할 수 있으며 이외에도 메세지 기능 등을 사용할 수 있습니다.
- 강사는 매니저와 비슷하게 근퇴 시스템을 통해 출퇴근 할 수 있으며 수업 관리, 시험 관리, 학생 관리 등 자신이 수업하는 반에 대한 모든 업무를 담당합니다.
- 학생은 근퇴 시스템과 비슷하게 출석 시스템을 통해 출석 할 수 있으며 수업 참여부터 시험, 강의 평가까지 강사와 매니저가 제공해주는 다양한 서비스를 사용할 수 있습니다. 또한 스터디 그룹 기능을 통해 채팅방을 만들고 참여하여 그룹 채팅 기능을 이용할 수 있습니다.

<br>

## 팀원 구성

<div align="center">

| **손수호** | **전민곤** | **이희원** | **김수진** | **정서현**|
| :------: |  :------: | :------: | :------: | :------: |

</div>

<br>

## 1. 개발 환경

- Front : HTML, jsp, javascript
- Back-end : java, oracle, spring
- 버전 및 이슈관리 : Github
- 협업 툴 : Notion
- 서비스 배포 환경 : AWS, tomcat
- 디자인 : [bootstrap](https://getbootstrap.kr/), figma

 [화면설계서](https://www.figma.com/design/Kmh6rmDV0KwjXQ5dAgwUsa/3%EC%B0%A8-%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8?node-id=66-390&t=YlM9dhHRBGOD9sMQ-1)

<br>

## 2. 중요 프로젝트 구조

```
├── README.md
└── Last-project
     ├── pom.xml
     ├── .springBeans
     ├── .project
     ├── .classpath
     ├── .settings
     ├── src
          ├── main
               ├── java
                    ├── admin/controller
                         ├── AdminMainController.java
                         ├── AdminRequestDeleteController.java
                         ├── AdminRequestDetailController.java
                         ├── AdminRequestListController.java
                         ├── AdminSituController.java
                         ├── ChangeAddrController.java
                         ├── ChangeImageController.java
                         ├── ChangePhoneController.java
                         ├── ChangePwController.java
                         ├── EmplListController.java
                         ├── ExcelDownloadController.java
                         ├── IdDeleteController.java
                         ├── IdInsertController.java
                         ├── IdUpdateController.java
                         ├── LectureDeleteController.java
                         ├── LectureDetailController.java
                         ├── LectureInsertController.java
                         ├── LectureListController.java
                         └── LectureUpdateController.java
                    ├── alarm
                         ├── controller
                              └── AlarmController.java
                         └── model
                              ├── AlarmBean.java
                              ├── AlarmDao.java
                              ├── AlarmService.java
                              ├── InterAlarmDAO.java
                              └── InterAlarmService.java
                    ├── com/spring
                         ├── config
                              ├── EchoHandler.java
                              └── WebSocketConfig.java
                         ├── ex
                              ├── DeleteChatController.java
                              ├── EnterController.java
                              ├── HomeController.java
                              ├── MainController.java
                              └── MakeChatController.java
                         └── model
                              ├── ChatBean.java
                              └── ChatDao.java
                    ├── evaluation/model
                         ├── EvaluationBean.java
                         ├── EvaluationDao.java
                         ├── EvaluationResultBean.java
                         └── EvaluationResultDao.java
                    ├── excel
                         ├── IdExcelReader.java
                         ├── LectureExcelReader.java
                         └── StuExcelReader.java
                    ├── lecture/model
                         ├── DetailBean.java
                         ├── LectureBean.java
                         ├── LectureDao.java
                         ├── On_going_lectureBean.java
                         └── On_going_lectureDao.java
                    ├── library/model
                         ├── LibraryBean.java
                         └── LibraryDao.java
                    ├── login
                         ├── controller
                              ├── FindPwController.java
                              ├── LoginController.java
                              └── LogoutController.java
                         └── model
                              ├── LoginBean.java
                              └── LoginDao.java
                    ├── manager
                         ├── controller
                              ├── LectureEvaluationController.java
                              ├── ManagerAttendController.java
                              ├── ManagerAttendStatusController.java
                              ├── ManagerCalendarController.java
                              ├── ManagerEtcController.java
                              ├── ManagerEtcListController.java
                              ├── ManagerLectureListController.java
                              ├── ManagerMainController.java
                              ├── ManagerNoticeController.java
                              ├── ManagerSelectDeleteController.java
                              ├── ManagerSituController.java
                              ├── ManagerStuDeleteController.java
                              ├── ManagerStuInsertController.java
                              ├── ManagerVacationController.java
                              ├── MangerEtcDetailController.java
                              ├── MangerRequestDetailController.java
                              ├── MangerRequestListController.java
                              └── RequestController.java
                         └── model
                              ├── EtcBean.java
                              ├── EtcDao.java
                              ├── EtcJoinMemberBean.java
                              ├── ManagerAttendDao.java
                              ├── ManagerDao.java
                              ├── NoticeBean.java
                              ├── NoticeDao.java
                              ├── RequestBean.java
                              ├── RequestDao.java
                              ├── RequestJoinMemberBean.java
                              ├── mCalendarBean.java
                              ├── mCalendarDao.java
                              ├── member/model
                              ├── AttendBean.java
                              ├── MemberBean.java
                              └── MemberDao.java
                    ├── messenger
                         ├── controller
                              ├── MessengerDeleteRecvController.java
                              ├── MessengerDeleteSendController.java
                              ├── MessengerDetailController.java
                              ├── MessengerReceiveListController.java
                              ├── MessengerReplyFormController.java
                              ├── MessengerSelectedListController.java
                              ├── MessengerSendController.java
                              ├── MessengerSendListController.java
                              ├── MessengerTopMenuController.java
                              └── MessengerUnreadController.java
                         └── model
                              ├── MessengerBean.java
                              └── MessengerDao.java
                    ├── mybatis
                         ├── SqlMapConfig.xml
                         ├── admin.xml
                         ├── alarm.xml
                         ├── chat.xml
                         ├── evaluation.xml
                         ├── lecture.xml
                         ├── library.xml
                         ├── login.xml
                         ├── manager.xml
                         ├── member.xml
                         ├── messenger.xml
                         ├── student.xml
                         ├── teacher.xml
                         ├── test.xml
                         └── testResult.xml
                    ├── student
                         ├── controller
                              ├── ClassNowController.java
                              ├── EvaluationContentController.java
                              ├── EvaluationListController.java
                              ├── SRequestController.java
                              ├── SRequestSignController.java
                              ├── StudentAttendController.java
                              ├── StudentAttendStatusController.java
                              ├── StudentCalendarController.java
                              ├── StudentEtcController.java
                              ├── StudentEtcDetailController.java
                              ├── StudentEtcListController.java
                              ├── StudentEtcReplyController.java
                              ├── StudentMainController.java
                              ├── StudentRequestDetailController.java
                              ├── StudentRequestListController.java
                              ├── StudentSelectDeleteController.java
                              ├── StudentVacationDetailController.java
                              ├── TestContentController.java
                              └── TestListController.java
                         └── model
                              ├── AttendBean.java
                              ├── AttendDao.java
                              ├── SEtcBean.java
                              ├── SEtcDao.java
                              ├── SRequestBean.java
                              ├── SRequestDao.java
                              ├── StudentAttendDao.java
                              ├── StudentDao.java
                              ├── sCalendarBean.java
                              └── sCalendarDao.java
                    ├── teacher
                         ├── controller
                              ├── ContentLibraryController.java
                              ├── DeleteAllLibraryController.java
                              ├── DeleteLibraryController.java
                              ├── EndTeachingController.java
                              ├── EvalResultContentController.java
                              ├── EvalResultListController.java
                              ├── TeacherAttendController.java
                              ├── TeacherAttendStatusController.java
                              ├── TeacherHomeController.java
                              ├── TeacherLibraryController.java
                              ├── TeachingController.java
                              ├── TestResultContentController.java
                              ├── TestResultController.java
                              ├── TestWriteController.java
                              ├── UpdateLibraryController.java
                              └── WriteLibraryController.java
                         └── model
                              ├── TeacherAttendDao.java
                              └── TeacherDao.java
                    ├── test/model
                         ├── NormalDistribution.java
                         ├── TestBean.java
                         ├── TestDao.java
                         ├── TestResultBean.java
                         └── TestResultDao.java
                    └── utility
                         ├── Paging.java
                         └── Sha256.java
               ├── resources
               └── webapp
                    ├── META-INF
                    ├── WEB-INF
                         ├── admin
                              ├── adminBarBottom.jsp
                              ├── adminBarTop.jsp
                              ├── adminMain.jsp
                              ├── emplList.jsp
                              ├── idInsertForm.jsp
                              ├── lectureInsertForm.jsp
                              ├── lectureList.jsp
                              ├── requestDetail.jsp
                              ├── requestList.jsp
                              └── requestList2.jsp
                         ├── all
                              ├── alarmModal.jsp
                              ├── board.jsp
                              ├── message.jsp
                              ├── myPage.jsp
                              └── topMenuMessage.jsp
                         ├── common
                              └── common.jsp
                         ├── login
                              ├── loginForm.jsp
                              └── result.jsp
                         ├── manager
                              ├── attendStatusForm.jsp
                              ├── calendarForm.jsp
                              ├── etcDetail.jsp
                              ├── etcForm.jsp
                              ├── etcList.jsp
                              ├── etcSendList.jsp
                              ├── home.jsp
                              ├── lectureEvalWriteForm.jsp
                              ├── lectureEvalWriteSuccess.jsp
                              ├── managerAttendanceCheck.jsp
                              ├── managerBarBottom.jsp
                              ├── managerBarTop.jsp
                              ├── myLectureList.jsp
                              ├── noticeDetailForm.jsp
                              ├── noticeForm.jsp
                              ├── noticeInsertForm.jsp
                              ├── noticeUpdateForm.jsp
                              ├── requestDetail.jsp
                              ├── requestForm.jsp
                              ├── requestList.jsp
                              ├── requestList2.jsp
                              ├── scheduleDetail.jsp
                              ├── scheduleInsert.jsp
                              ├── scheduleUpdate.jsp
                              ├── scheduleView.jsp
                              ├── stuInsertForm.jsp
                              └── vacationDetail.jsp
                         ├── messenger
                              ├── messengerMain.jsp
                              └── messengerSendList.jsp
                         ├── spring
                              ├── appServlet
                                   ├── admin-context.xml
                                   ├── alarm-context.xml
                                   ├── lecture-context.xml
                                   ├── login-context.xml
                                   ├── manager-context.xml
                                   ├── member-context.xml
                                   ├── messenger-context.xml
                                   ├── servlet-context.xml
                                   ├── student-context.xml
                                   └── teacher-context.xml
                              └── root-context.xml
                         ├── student
                              ├── attendStatusForm.jsp
                              ├── classNow.jsp
                              ├── classNowSuccess.jsp
                              ├── etcDetail.jsp
                              ├── etcDetail2.jsp
                              ├── etcForm.jsp
                              ├── etcList.jsp
                              ├── etcSendList.jsp
                              ├── eval.jsp
                              ├── evalContent.jsp
                              ├── evalList.jsp
                              ├── evalSuccess.jsp
                              ├── home.jsp
                              ├── replyEtcForm.jsp
                              ├── requestDetail.jsp
                              ├── requestForm.jsp
                              ├── requestList2.jsp
                              ├── save.jsp
                              ├── studentAttendanceCheck.jsp
                              ├── studentBottom.jsp
                              ├── studentTop.jsp
                              ├── test.jsp
                              ├── testContent.jsp
                              ├── testList.jsp
                              ├── testSuccess.jsp
                              └── vacationDetail.jsp
                         ├── teacher
                              ├── WriteForm.jsp
                              ├── attendStatusForm.jsp
                              ├── contentLibrary.jsp
                              ├── evalResultContent.jsp
                              ├── evalResultList.jsp
                              ├── home.jsp
                              ├── library.jsp
                              ├── teacherAttendanceCheck.jsp
                              ├── teacherBottom.jsp
                              ├── teacherTop.jsp
                              ├── teaching.jsp
                              ├── teachingForm.jsp
                              ├── testList.jsp
                              ├── testResultContent.jsp
                              ├── testWriteForm.jsp
                              ├── testWriteSuccess.jsp
                              ├── updateLibraryForm.jsp
                              └── writeLibraryForm.jsp
                         ├── views
                              ├── home.jsp
                              ├── main.jsp
                              ├── makeForm.jsp
                              ├── studentBottom.jsp
                              └── studentTop.jsp
                         └── web.xml
                    ├── pages
                    ├── resources
                    └── Main.jsp
          └── test/resources
```

<br>

## 4. 역할 분담

### 🐸손수호

- **UI**
    - 페이지 : 강의 평가 시행, 시험 출제, 시험 결과, 강의 평가 결과, 수업 시작, 시험 리스트, 시험, 강의 평가 리스트, 강의 평가, 채팅방 리스트, 채팅방
    - 공통 컴포넌트 : 강사 홈, 학생 홈, 로그인
- **기능**
    - 시험 출제 및 응시, 강의 평가 시행 및 응시, 채팅방 생성&삭제 및 참여, 시험 결과 확인, 강의 평가 결과 확인, 로그인 기능

<br>
    
### 👻전민곤

- **UI**
    - 페이지 : 문서 보내기, 결재 문서 보내기, 받은 문서함, 보낸 문서함, 받은 결재함, 보낸 결재함, 알림창
    - 공통 컴포넌트 : 관리자 홈, 매니저 홈, 강사 홈, 학생 홈, 알림
- **기능**
    - 문서 보내기, 결재 문서 보내기, 문서/결재문서-상세보기/삭제, 결재문서 승인 반려, 관리자,매니저,강사,학생 알림 기능 

<br>

### 😎김수진

- **UI**
    - 페이지 : 메시지 보내기, 보낸 메시지함, 받은 메시지함, gnb 메신저 메뉴
    - 공통 컴포넌트 : 메신저
- **기능**
    - 메시지 보내기, 메시지 삭제, 최신 메시지 3개 탑 메뉴 노출, 안 읽은 메시지만 보기

<br>

### 🐬정서현

- **UI**
    - 페이지 : 강좌목록, 강좌개설, 직원목록, 직원아이디생성, 내수업정보, 학생등록
    - 공통 컴포넌트 : 관리자 홈, 매니저 홈, 강사 홈, 학생 홈, 로그인
- **기능**
    - 강좌 생성/삭제/수정/상세조회, 직원 생성/삭제, 학생 생성, 개인정보수정, 비밀번호찾기

### 🍊이희원

- **UI**
    - 페이지 : 일정관리, 공지사항 관리, 근태관리
    - 공통 컴포넌트 : 매니저 홈, 강사 홈, 학생 홈
- **기능**
    -  출근(출석)/퇴근(퇴실), 근태관리, 일정관리(추가,수정,삭제), 공지사항 관리(추가, 수정, 삭제)

<br>

## 5. 개발 기간 및 작업 관리

### 개발 기간

- 전체 개발 기간 : 2024-6-20 ~ 2024-7-23
- 기능 구현 : 2024-6-20 ~ 2024-7-16
- UI 구현 : 2024-7-16 ~ 2022-7-23

<br>

### 작업 관리

- Notion과 github를 사용하여 진행 상황을 공유했습니다.
- 프로젝트를 진행하기전 회의를 통해 작업 순서와 방향성에 대한 고민을 나누고 Notion에 회의 내용을 기록했습니다.
- 주기적으로 점심시간에 팀 회의를 통해 현재 진행 상황과 문제를 공유하고 추가할 내용을 같이 의논하며 프로젝트를 진행하였습니다.

<br>

## 6. 기능

### [로그인]
- 이메일 주소와 비밀번호를 입력하면 입력창에서 바로 유효성 검사가 진행되고 통과하지 못한 경우 각 경고 문구가 입력창 하단에 표시됩니다.
- 이메일 주소의 형식이 유효하지 않거나 비밀번호가 6자 미만일 경우에는 각 입력창 하단에 경구 문구가 나타납니다.
- 작성이 완료된 후, 유효성 검사가 통과된 경우 로그인 버튼이 활성화됩니다.
- 로그인 버튼 클릭 시 이메일 주소 또는 비밀번호가 일치하지 않을 경우에는 경고 문구가 나타나며, 로그인에 성공하면 홈 피드 화면으로 이동합니다.

### [비밀번호 찾기]
- 아이디와 전화번호를 입력하고 인증번호 발급을 누르면 해당 전화번호로 인증번호가 전송되고, 인증번호가 일치하는 경우에만 새로운 비밀번호를 설정할 수 있습니다.
- 아이디와 전화번호를 누락한 경우, 전화번호 형식이 010~ 이 아닌경우, 일치하는 회원정보가 없는 경우 경고창이 나타납니다.
- 인증번호 발급 버튼을 누른 후 3분 타이머가 시작되어 보여지며, 시간이 모두 경과한 경우 인증번호 발급을 다시 받아 진행해야합니다.


### [강좌관리]
- 조회(관리자) : 관리자는 모든 강좌를 조회할 수 있으며, 관리자 홈화면에서 모든 클래스의 강좌 진행 현황을 확인할 수 있습니다. (해당 반에 진행중인 강좌가 없다면 예정 강좌를, 예정 강좌가 없다면 종료 강좌 중 가장 최근의 것을 보여줍니다.) 이때, 검색 기능을 통해 원하는 정보를 조회할 수 있습니다.
- 조회(매니저) : 매니저는 자신의 담당 강좌를 조회할 수 있으며, 매니저 홈화면에서 현재 진행중이거나 예정된 강좌 정보를 확인할 수 있습니다. 이때, 검색 기능을 통해 원하는 정보를 조회할 수 있습니다.
- 조회(강사/학생) : 강사와 학생은 각자의 홈화면에서 진행중인 강좌의 정보를 자세히 확인할 수 있습니다.
  <br>! 강좌별 세부 정보 확인이 가능하며, 이것에는 강좌정보, 매니저/강사/학생 정보가 모두 담겨있습니다.
- 추가 : 관리자는 직접기입, 엑셀파일업로드 두가지 방식으로 강좌를 개설할 수 있습니다.
  <br>! 직접기입 : 원하는 만큼의 행을 추가하여 기재한 뒤 데이터를 모두 추가할 수 있습니다. 이때 누락된 부분이 있다면 경고 표시가 나타납니다.
  <br>! 엑셀파일업로드 : 먼저 양식 파일 다운로드 버튼을 눌러 파일을 받습니다. 해당 파일에 원하는 만큼의 데이터를 미리 준비한 뒤, 파일 업로드 작업을 통해 데이터를 모두 추가할 수 있습니다. 이때 파일은 xlsx 형식일 경우에만 업로드 가능합니다.
- 수정 : 관리자는 강좌 목록에서 수정하고 싶은 강좌의 상세정보를 수정할 수 있습니다. 수정버튼을 눌러 진행되며, 해당 강좌의 상세정보가 기본적으로 표시되도록 설정되어있습니다. 이후 수정을 하게되면 페이지 새로고침없이 ajax를 이용하여 변경내용이 즉시 보여지게 됩니다.
- 삭제 : 관리자는 강좌 목록에서 원하는 강좌들을 선택하여 한번에 삭제할 수 있습니다. 검색 기능을 통해 원하는 정보를 조회중인 경우에도 해당 페이지로 다시 이동하여 변경 내용을 쉽게 확인할 수 있습니다.


### [직원관리]
- 조회 : 관리자는 모든 직원을 조회할 수 있으며, 검색 기능을 통해 원하는 정보를 조회할 수 있습니다.
- 추가 : 관리자는 직접기입, 엑셀파일업로드 두가지 방식으로 직원 정보를 생성할 수 있습니다.
  <br>! 직접기입 : 원하는 만큼의 행을 추가하여 기재한 뒤 데이터를 모두 추가할 수 있습니다. 이때 누락된 부분이 있다면 경고 표시가 나타납니다.
  <br>! 엑셀파일업로드 : 먼저 양식 파일 다운로드 버튼을 눌러 파일을 받습니다. 해당 파일에 원하는 만큼의 데이터를 미리 준비한 뒤, 파일 업로드 작업을 통해 데이터를 모두 추가할 수 있습니다. 이때 파일은 xlsx 형식일 경우에만 업로드 가능합니다.
- 삭제 : 관리자는 직원 목록에서 원하는 직원들을 선택하여 한번에 삭제할 수 있습니다. 검색 기능을 통해 원하는 정보를 조회중인 경우에도 해당 페이지로 다시 이동하여 변경 내용을 쉽게 확인할 수 있습니다.


### [학생관리]
- 조회 : 매니저는 자신이 담당하는 강좌 상세정보에 담긴 학생 정보를 확인할 수 있습니다.
- 추가 : 매니저는 자신이 담당하는 강좌를 선택하여 직접기입, 엑셀파일업로드 두가지 방식으로 학생 정보를 생성할 수 있습니다.
  <br>! 직접기입 : 원하는 만큼의 행을 추가하여 기재한 뒤 데이터를 모두 추가할 수 있습니다. 이때 누락된 부분이 있다면 경고 표시가 나타납니다.
  <br>! 엑셀파일업로드 : 먼저 양식 파일 다운로드 버튼을 눌러 파일을 받습니다. 해당 파일에 원하는 만큼의 데이터를 미리 준비한 뒤, 파일 업로드 작업을 통해 데이터를 모두 추가할 수 있습니다. 이때 파일은 xlsx 형식일 경우에만 업로드 가능합니다.


### [마이페이지]
- 관리자를 제외한 매니저/강사/학생 회원은 등록된 자신의 개인정보를 확인하고 수정할 수 있습니다.
- 프로필 변경 : 원하는 프로필 이미지를 선택하여 변경할 수 있고, 변경 내용은 새로고침 후 확인할 수 있습니다.
- 비밀번호 변경 : 현재 비밀번호, 새 비밀번호, 새 비밀번호 확인 이렇게 세가지를 입력한 후 비밀번호 정보를 수정할 수 있습니다. 입력값이 누락된경우, 현재 비밀번호가 등록된 정보와 일치하지 않는경우, 새 비밀번호와 새 비밀번호 확인이 일치하지 않는 경우에는 경고창이 나타납니다. 
- 전화번호 변경 : 새로운 전화번호를 입력한 뒤 해당 번호로 인증번호를 발급받아, 일치하는 값을 입력했을 경우 전화번호가 즉시 변경되어 보여지게 됩니다.  인증번호 발급 버튼을 누른 후 3분 타이머가 시작되어 보여지며, 시간이 모두 경과한 경우 인증번호 발급을 다시 받아 진행해야합니다.
- 주소 변경 : 원하는 주소를 직접 기입하여 변경하게 되면 내용이 즉시 변경되어 보여지게 됩니다.

 ### [메신저]
- 학생은 본인과 관리자를 제외한 모두에게 메시지를 보낼 수 있습니다.
- 매니저와 강사는 관리자에게도 메시지보내기가 가능합니다.
- 최신 메시지 알림 : gnb 메뉴에 메시지 알림 아이콘 클릭 시 최신 메시지 3개를 가져옵니다. 받은 메시지 중에 최신 메시지가 있을 때 노티 아이콘 활성화 됩니다. 최신 메시지 클릭 또는 메시지 더보기 클릭 시 받은 메시지함으로 갑니다.
- 받은 메시지 리스트 : 받은 메시지함에서 읽은 메시지와 안 읽은 메시지를 구분합니다. 안 읽은 메시지만 보기 하여 필터링을 할 수 있습니다. 받은/보낸 메시지함에서 검색어 입력시 이름, 제목으로 검색 가능합니다.
- 받은 메시지 상세보기 :메시지 리스트에서 행을 클릭하면 해당 상세보기 팝업이 나타납니다.
- 답장하기 : 상세보기에서 답장하기 버튼 클릭시 기존 원글 re:타이틀, 받는사람이 자동으로 입력됩니다. (이 때 수정은 불가합니다.)
- 메시지 보내기 : 메시지 보내기에서 제목과 내용, 받는 사람이 입력할 때 유효성검사를 실시합니다. 메시지 보내기에서 받는사람 여러명 지정하여 한번에 메시지를 보낼 수 있습니다.

 ### [수업]
- 강사는 수업을 시작할 수 있습니다.
- 수업 시작 : 강사가 수업을 시작할시 구글 meet 페이지로 넘어가게된다. 구글 meet에서 회의를 시작하여 해당 회의 링크 주소를 가져와 입력하고 전송하면, 해당 강좌를 수강하는 모든 학생들에게 해당 링크가 전송된다.
- 수업 참여 : 학생은 수업에 참여할 수 있다. 강사가 수업을 시작하여 구글 meet 회의 주소를 전송하였다면 해당 주소로 들어갈 수 있지만, 수업이 시작되지 않았다면 '진행중인 수업이 없습니다' 경고창이 나오게 된다.
- 수업 종료 : 강사가 수업을 시작하다면 수업 시장 버튼은 '수업 종료' 버튼으로 변경된다. 이후 강사가 로그아웃하거나 해당 버튼을 눌르기 전까지는 수업은 진행중인 상태로 나타난다. 강사가 '수업 종료' 버튼을 누르면 진행중인 수업은 없게 되어 이후 학생이 수업에 참여하려고 하면 위 경고창이 나타난다.

 ### [시험]
- 강사는 시험을 만들수 있으며, 학생은 강사가 만든 시험을 응시할 수 있다. 또한 강사는 학생의 시험 결과를 확인할 수 있다
- 시험 조회 : 강사와 학생 모두 시험을 조회 할 수 있다. 학생의 경우 응시하지 않은 시험은 응시할 수 있으며 응시한 시험의 경우 응시할 수 없지만 시험 결과 점수를 확인할 수 있다.
- 시험 출제 : 강사는 시험 출제를 할 수 있다. 강사가 시험 조회 화면에서 '시험 출제' 버튼을 클릭하면 시험 출제 화면이 새로 생기고 해당 창에서 시험 타이틀과 각 문제별 내용과 자료, 선택지, 정답을 입력할 수 있다. 강사가 모든 문제에 대한 내용 작성을 완료하여 '출제하기' 버튼을 누를시 해당 강좌를 수강하는 모든 학생들에게 출제한 시험이 새로 생기게 되며 응시할 수 있게 된다.
- 시험 응시 : 학생은 위에서 강사가 출제한 시험을 응시할 수 있다. 학생은 강사가 출제한 시험을 클릭하면 시험 화면이 새로 생기고 해당 창에서 시험을 응시하면 된다. 해당 창에는 시험 내용 뿐만 아니라 시간 제한을 나타내는 타이머가 존재하는데, 학생은 시간내에 시험을 완료하지 못할시 자동으로 시험이 종료되고 그동안 작성한 답이 제출된다. 학생이 시험 응시를 완료하였다면 학생은 해당 시험을 다시 응시할 수 없다. 시험을 다시 조회하면 시험 응시가 불가능하게 변한 것을 확인할 수 있고, 또 추가로 해당 시험 결좌 점수가 출력된다.
- 시험 결과 : 강사는 학생들이 응시한 시험의 결과를 확인할 수 있다. 평균과 분산, 그리고 이를 나타낸 막대 그래프와 합격자와 불합격자 비율을 보여주는 원형 그래프, 마지막으로 시험에 응시한 총 학생 점수를 베이스로한 정규분포표와 불합격자 명단을 확인할 수 있다. 불합격자의 경우 시험 점수가 60점 미만인 경우를 말하며 강사는 해당 학생들을 확인할 수 있다.

 ### [강의 평가]
-
-

 ### [스터디 그룹]
-
-

 ### [결재관리]
- 학생은 매니저에게만 보낼 수 있고 매니저는 관리자에게만 보낼 수 있습니다
- 받은 결재함(승인필요) / 결재 문서함(완료) 리스트 조회
- <문서함별로 페이징>
- 받은 결재함에서 문서함 리스트에 승인필요 표시, 문서 내용에 반려,승인버튼 활성화
- canvas 사용하여 결재에 필요한 사인기능
- 이름, 제목, 내용으로 검색가능

### [문서]
- 학생은 매니저에게만 보낼 수 있고 매니저는 학생에게만 보낼 수 있습니다
- 보낸 문서와 받은 문서 페이지로 구성
- 받은 메신저의 경우 답장하기 기능 구현
- 문서는 매니저,학생 다중선택하여 보낼 수 있음
- 다중 첨부파일 첨부 드래그앤 드롭 파일첨부, 다운로드 기능
- 이름, 문서 제목, 문서 내용으로 검색가능
- <문서함별로 페이징>

### [알림]
- 새로운 소식 열람하지 않은 알림, 지난 소식은 열람한 알람들 중 7일 안에 온 알람이 보인다.
 새로운 소식에 추가되는 경우
- 전체공지 / 학생이 속한 반의 공지가 올라올 때
- 해당 학생,매니저가 문서를 보냈을 때
- 해당 학생,매니저가 결재해야하는 결재 문서가 작성됐을 때
- 해당 학생,매니저가 쓴 결재 문서가 결재가 승인/반려/결재완료 되었을 때
- 해당 강사,매니저의 강좌 생성,변경이 있을 때
- 해당 강사가 수업을 시작했을 때
- 해당 강사가 시험을 시작했을 때
 

## 7. 개선할 부분

- 수업 하기 내용이 google meeting의 웹 페이지를 띄워서 사용자가 직접 주소링크를 가져와 입력하였는데, 이걸 google workspace의 oauth api를 사용하면 java 파일 안에서 핸들링 할 수 있는 방법이 있습니다. 이를 적용하면 더 깔끔하게 UI 제공할 수 있을 것 같습니다.
  
- 웹 소켓을 사용하여 스터디 그룹 채팅방을 구혈할 때 하나의 소켓만 만들어서 구형하였습니다. 여러 사람이 여러 채팅방에서 채팅을 하지만 전부 하나의 소켓에서 채팅을 하는 것이며, 해당 채팅방의 메세지만 해당 채팅방에 보이도록 작업한 것입니다. 하지만 실제 현실에서는 각 채팅방마다 소켓이 만들어지므로 여러개의 소켓(채팅방)을 핸들링 할 줄 알아야 할 것입니다. 따라서 웹 소켓에 대하여 좀 더 공부하여 각 채팅방마다 소켓을 만들어주는 작업으로 수정해야 할 것입니다.

- 배포과정에서 HTTPS 보안 프로토콜 연결을 하지 않았는데(SSL 인증서를 구매하여 사용해야 한다고 해서 포기했습니다), 그래서 프로젝트 중 사용자 위치를 받아오는 geolocation api가 사용되었지만 보안 프로토콜 연결이 아니므로 AWS 에서 거부하는 일이 발생하였습니다. HTTPS 보안 프로토콜 연결을 해서 이 문제를 해결해야 할 것입니다.

- 배포 과정에서 보안이나 부하를 고려하지 않았는데, AWS를 제대로 공부하여 보안과 부하를 고려해서 다시 배포해야할 것 입니다.

<br>

## 8. 프로젝트 후기

### 🐸 손수호

팀장 역할로 프로젝트를 수행해보는 것은 처음이었는데, 한 명이 부상으로 이탈하는 상황이 발생하는 등 여러 문제가 있었지만, 남은 팀원들과 함께 협력하여 해결해 나가면서 최종적으로 목표했던 배포까지 완수할 수 있었습니다. 그 과정에서 리더십과 팀워크 등 많은 것을 배울 수 있었습니다.

또한, 웹 소켓과 배포 등 어렵고 아직 배우지 못한 내용들에 도전하고 달성하면서 많은 것을 배울 수 있었습니다. 웹 소켓을 구현하면서 줌이나 실시간 중계 등 오늘날 현실에서 웹 소켓이 어떻게 적용되고 작동하는지 이해하게 되었습니다. 또한, 배포 작업을 통해 사용자가 알 수 없는 서버의 작동 방식을 실질적으로 경험할 수 있었습니다.

물론, 앞에서 설명했듯이 개선해야 할 내용이 많습니다. 여러 개의 소켓을 핸들링하는 방법이나 배포 시 보안과 부하를 고려하는 등의 미숙한 부분이 아직 남아 있습니다. 하지만 이러한 경험을 바탕으로 더 공부하고, 끊임없이 노력하여 앞으로 더욱 전문적이고 능숙한 개발자가 되겠습니다. 이번 프로젝트 경험이 그런 개발자가 되는 데 큰 도움이 된 것 같아 기쁩니다.

<br>

### 👻 전민곤
프로젝트를 진행하면서 그동안 배운 내용을 기반으로 다양한 새로운 방법을 활용할 수 있는 기회가 있었습니다. 처음에는 목표를 설정하고 방향을 잡는 데 시간이 조금 걸리긴 했지만, 일단 목표를 명확히 정하고 나니 앞으로 나아가야 할 길이 보였습니다. 목표를 설정하고 나서부터는 어떤 방식으로 접근해야 할지 명확해졌고, 그에 따라 차근차근 작업을 진행할 수 있었고 팀원들간 의사소통의 중요함을 알게되었습니다.

또한, 이번 프로젝트를 통해 배포 과정을 처음으로 시도해보았습니다. 배포 과정에서는 환경 설정, 서버 구성, 오류 처리 등 다양한 문제들을 해결해야 했고, 이를 통해 실제 서비스 운영에 필요한 기술적 역량을 키울 수 있었습니다. 이러한 과정을 통해 많은 것을 배우고 성장할 수 있었던 소중한 경험이었습니다.

<br>

### 😎 김수진

팀 프로젝트를 진행하며, 프로젝트의 기능 및 목표와 범위를 설정하고, 명세서를 작성하는 등 단계별로 일정에 맞춰 진행하였습니다.
어떤 서비스를 제공할지 결정하고 어떤 기능을 넣을지 구성하고, 제공하는 서비스의 전반적인 흐름을 경험한 좋은 기회였던 것 같습니다.
프로젝트를 여러사람과 함께하게 되어서 문제를 바라보는 관점을 다양하게 접하고 해결 능력을 키울수 있었습니다.

이번 팀프로젝트를 경험하면서 사회에서의 프로젝트를 조금이나마 경험 한 것 같아, 다음에는 비슷한 상황에서 좀 더 자신감있게 대응할 수 있을 것 같습니다.
많이 알려주고 함께 문제 해결해준 팀원들에게 감사합니다.

<br>

### 🐬 정서현

이번 팀 프로젝트를 통해 그동안 배워왔던 Spring, MyBatis, Oracle DB 등의 기술들을 실제로 활용할 수 있었던 좋은 기회였습니다. 비록 처음에는 원하는 방향으로 나아가는 데 많은 어려움이 있었지만, 부딪혀가며 한 달간 프로젝트를 수행하면서 점차 AJAX, DB 관리, API 활용 등 다양한 부분에 적응할 수 있었습니다.

특히 DB를 수정하거나 계획을 변경하는 과정에서 발생한 문제점들을 해결해나가는 경험들은 많은 깨달음을 얻게 해주었습니다. 이를 통해 향후 프로젝트를 진행할 때 더욱 효과적으로 대처할 수 있을 것이라는 자신감이 생겼습니다.

물론 세부적인 부분들에 대한 수정이 필요하고 아쉬움이 남는 부분도 있지만, 이번 프로젝트를 통해 얻은 경험을 바탕으로 앞으로 더욱 발전해 나갈 수 있을 것이라 확신합니다. 이러한 과정을 통해 실무 능력이 크게 향상되었다고 생각하며, 앞으로도 끊임없이 노력하여 더 나은 개발자가 되고자 합니다.

<br>

### 🍊 이희원

이번 팀 프로젝트는 지금까지 수업에서 배운 내용 외에도 여러 가지 새로운 기술들을 터득할 수 있어 매우 뜻깊은 시간이었습니다. 특히, 혼자 기능 구현을 하면서 많은 어려움을 겪기도 했지만, 팀에 피해를 끼치지 않기 위해 더 열심히 고민하고 해결하려는 책임감이 생겼습니다. 덕분에 이전 프로젝트들보다 더 많은 성장을 할 수 있었습니다.

처음 사용해보는 API와 부트스트랩 등을 통해 새로운 기술을 익힐 수 있었고, Notion, ERD, GIT 등의 도구들을 더 적극적으로 활용해야겠다는 생각이 들었습니다. 이 과정에서 형상 관리의 중요성을 깨닫게 되었고, GIT을 통해 코드를 통합하는 방법을 배웠습니다. 다만, 개인별로 DB가 달라서 데이터베이스 통일의 중요성과 팀원 간 변경 사항의 공유 필요성을 다시 한번 인식하게 되었습니다.

프로젝트 기간 내에 모든 기능을 완벽히 구현하지는 못해 아쉬움도 남지만, 한 달간 팀원들과 여러 위기 상황을 겪으면서 오히려 더 성장할 수 있는 기회가 되었습니다. 부족한 부분이 있었기에 스스로 더욱 발전할 수 있었던 것 같습니다. 앞으로도 더 많은 공부를 통해 좋은 개발자가 되도록 노력하겠습니다.

