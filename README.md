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
- 서비스 배포 환경 : AWS
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
    - 페이지 : 강의 평가 시행, 험 출제, 시험 결과, 강의 평가 결과, 수업 시작, 시험 리스트, 시험, 강의 평가 리스트, 강의 평가, 채팅방 리스트, 채팅방
    - 공통 컴포넌트 : 강사 홈, 학생 홈, 로그인
- **기능**
    - 시험 출제 및 응시, 강의 평가 시행 및 응시, 채팅방 생성&삭제 및 참여, 시험 결과 확인, 강의 평가 결과 확인, 로그인 기능

<br>
    
### 👻전민곤

- **UI**
    - 페이지 : 
    - 공통 컴포넌트 : 
- **기능**
    - 

<br>

### 😎김수진

- **UI**
    - 페이지 : 
    - 공통 컴포넌트 : 
- **기능**
    - 

<br>

### 🐬정서현

- **UI**
    - 페이지 : 
    - 공통 컴포넌트 : 
- **기능**
    - 

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

- 

<br>

## 8. 프로젝트 후기

### 🐸 손수호

처음 배포를 해봤는데 ~~

<br>

### 👻 전민곤

~~

<br>

### 😎 김수진

~~

<br>

### 🐬 정서현현

~~

<br>

### 🍊 이희원

~~

