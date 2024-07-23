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
- 디자인 : [bootstrap](https://getbootstrap.kr/)

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
    - 페이지 : 
    - 공통 컴포넌트 : 알림
- **기능**
    - 

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
    - 페이지 : 
    - 공통 컴포넌트 : 
- **기능**
    -  

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

| 로그인 |
|----------|
|![login]|

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

~~

<br>

### 😎 김수진

~~

<br>

### 🐬 정서현

이번 팀 프로젝트를 통해 그동안 배워왔던 Spring, MyBatis, Oracle DB 등의 기술들을 실제로 활용할 수 있었던 좋은 기회였습니다. 비록 처음에는 원하는 방향으로 나아가는 데 많은 어려움이 있었지만, 부딪혀가며 한 달간 프로젝트를 수행하면서 점차 AJAX, DB 관리, API 활용 등 다양한 부분에 적응할 수 있었습니다.

특히 DB를 수정하거나 계획을 변경하는 과정에서 발생한 문제점들을 해결해나가는 경험들은 많은 깨달음을 얻게 해주었습니다. 이를 통해 향후 프로젝트를 진행할 때 더욱 효과적으로 대처할 수 있을 것이라는 자신감이 생겼습니다.

물론 세부적인 부분들에 대한 수정이 필요하고 아쉬움이 남는 부분도 있지만, 이번 프로젝트를 통해 얻은 경험을 바탕으로 앞으로 더욱 발전해 나갈 수 있을 것이라 확신합니다. 이러한 과정을 통해 실무 능력이 크게 향상되었다고 생각하며, 앞으로도 끊임없이 노력하여 더 나은 개발자가 되고자 합니다.

<br>

### 🍊 이희원

~~

