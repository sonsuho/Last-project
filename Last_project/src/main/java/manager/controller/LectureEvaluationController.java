package manager.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import alarm.model.AlarmService;
import evaluation.model.EvaluationBean;
import evaluation.model.EvaluationDao;
import evaluation.model.EvaluationResultDao;
import lecture.model.LectureBean;
import lecture.model.LectureDao;
import manager.model.ManagerDao;
import member.model.MemberBean;
import student.model.StudentDao;

@Controller
@ComponentScan({"manager,alarm,student,lecture,evaluation"})
public class LectureEvaluationController {
   
   final String command = "/lectureEval.manager";
   final String getPage = "lectureEvalWriteForm";
   final String gotoPage = "lectureEvalWriteSuccess";
   
   @Autowired
   ManagerDao mdao;
   
   @Autowired
   StudentDao sdao;
   
   @Autowired
   LectureDao ldao;
   
   @Autowired
   EvaluationDao edao;
   
   @Autowired
   EvaluationResultDao erdao;
   
   @Autowired
   AlarmService service;
   
   @RequestMapping(value = command,  method = RequestMethod.GET)
   public ModelAndView writeForm(HttpSession session) {
      
      ModelAndView mav = new ModelAndView();
      
      MemberBean manager = (MemberBean)session.getAttribute("loginInfo");
      
      List<LectureBean> list = ldao.getLectureByManager(manager.getMem_num());
      
      List<String> lec_names = new ArrayList<String>();
      
      List<Integer> classes = new ArrayList<Integer>();
      
      for(LectureBean lb : list) {
         
         String className = ldao.getClassNameByLec(String.valueOf(lb.getLec_num()));
         
         lec_names.add(className);
         
         classes.add(lb.getLec_num());
      }
      
      mav.addObject("lec_names", lec_names);
      mav.addObject("classes", classes);
      
      mav.setViewName(getPage);
      
      return mav;
   }
   
   @RequestMapping(value = command,  method = RequestMethod.POST)
   public ModelAndView write(HttpServletRequest request,HttpSession session , Map<String, String> paramap) {
      
      ModelAndView mav = new ModelAndView();
      
      String[] lec_nums = request.getParameterValues("lec_nums");
      
      for(String lec_num : lec_nums) {
         
         EvaluationBean eb = new EvaluationBean();
         
         String className = ldao.getClassNameByLec(lec_num);
         
         int count = edao.getEvalNumByLec(lec_num) + 1;
         
         eb.setLec_num(Integer.parseInt(lec_num));
         eb.setEval_content("제 " + count + "회 " + className + "강의 평가 조사");
         
         edao.insertEvaluation(eb);
      }
      
      
      //민곤 알림 추가
      MemberBean manager = (MemberBean)session.getAttribute("loginInfo");
      
      String lec_Num = manager.getLec_num();   
      
      List<MemberBean> slist = sdao.getStudentByLec_Num(lec_Num);      // 반복을 통해 해당 강좌를 수강하는 모든 학생들에게 수업 링크가 담긴 메시지를 보낸다

      StringBuilder stdList = new StringBuilder();
      for (MemberBean mb : slist) {
         if (stdList.length() > 0) {
         stdList.append(",");
         }
      stdList.append(mb.getMem_num());
      }
      System.out.println("stdList.toString():"+stdList.toString()); // 출력 확인
            
      paramap.put("fk_recipientno", stdList.toString()); // 받는사람 (여러명일때는 ,,으로 구분된 str)
      paramap.put("url", "/evalList" ); 
      paramap.put("url2", ".student"); //url2에 아무것도 안넣으면 알림 클릭했을때 주소창에null로 나와서 오류
      paramap.put("alarm_content", manager.getName() + "님 반의 강의평가가 열렸습니다." );
      paramap.put("alarm_type", "2" );
            
      service.addAlarm(paramap);
      //민곤 알림 추가
      
      mav.setViewName(gotoPage);
      
      return mav;
   }
}
