package student.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import student.model.AttendBean;
import student.model.AttendDao;

@Controller
public class AttendController {

   private final String startCommand = "/start.student";
   private final String finCommand = "/fin.student";
   

   final String getPage = "studentHome";
   final String gotoPage = "redirect:/home.student";
   final String checkOutPage = "redirect:/login.in";
   final String failPage = "/home.student";
   
   private final String startCommand2 = "/start.manager";
   private final String finCommand2 = "/fin.manager";
   
   final String getPage2 = "managerHome";
   final String gotoPage2 = "redirect:/home.manager";
   final String checkOutPage2 = "redirect:/login.in";
   final String failPage2 = "/home.manager";

   @Autowired
   AttendDao attendDao;

   @RequestMapping(value = startCommand, method = RequestMethod.GET)
   public String start() {
      return gotoPage;
   }

   @RequestMapping(value = startCommand, method = RequestMethod.POST)
   public ModelAndView start(
         @RequestParam(value = "mem_num", required = true) String mem_num,
         @RequestParam(value = "mem_ip", required = true) String mem_ip,
         @RequestParam(value = "mem_latitude", required = true) double mem_latitude,
         @RequestParam(value = "mem_longitude", required = true) double mem_longitude,
         HttpServletRequest request,
         HttpServletResponse response,
         HttpSession session) throws IOException, ParseException {

      System.out.println("DB(member) mem_num : " + mem_num);
      System.out.println("DB(member) mem_ip : " + mem_ip);
      System.out.println("DB(member) mem_latitude : " + mem_latitude);
      System.out.println("DB(member) mem_longitude : " + mem_longitude);

      ModelAndView mav = new ModelAndView();

      PrintWriter out = response.getWriter();

      // 사용자(학생)의 IP 주소 가져오기
      String stuIp = request.getParameter("ipAddress");   //로그인한 PC의 IP 주소
      System.out.println("학생PC의 IP : " + stuIp);
      
      // 사용자(학생)의 '출석'한 위치 가져오기
      double stuLatitude = Double.parseDouble(request.getParameter("latitude"));
      double stuLongitude = Double.parseDouble(request.getParameter("longitude"));
      
      System.out.println("학생PC의 latitude(위도) : " + stuLatitude);
      System.out.println("학생PC의 longitude(경도) : " + stuLongitude);
      
      double MinLatitude = mem_latitude - 0.1;
      double MaxLatitude = mem_latitude + 0.1;
      double MinLongitude = mem_longitude - 0.02;
      double MaxLongitude = mem_longitude + 0.02;

      if (stuIp != null && stuIp.equals(mem_ip)) {   //IP가 같다면
         if (stuLatitude <= MaxLatitude && stuLatitude >= MinLatitude) {
            if (stuLongitude <= MaxLongitude && stuLongitude >= MinLongitude) {
               
               int cnt = attendDao.insertCheck(mem_num, mem_ip);

               AttendBean ab2 = attendDao.getAttendPrimaryKey(mem_num, mem_ip);
               AttendBean ab = attendDao.getAttendListByAtt_num(ab2.getAtt_num());
               System.out.println("Controller insert att_num: " + ab.getAtt_num());
               System.out.println("Controller getAttendListByAtt_num test : " + ab.getAtt_sdate());

               String check_flag = "success";
               session.setAttribute("check_flag", check_flag);
               
               SimpleDateFormat dateFormat = new SimpleDateFormat("HH시mm분");
               String sdate_string = dateFormat.format(ab.getAtt_sdate()); //날짜가 string으로 저장
               String fdate_string = null; // ab.getAtt_fdate() == null
               
               session.setAttribute("att_sdate", sdate_string);
               session.setAttribute("att_fdate", fdate_string);
               
               System.out.println("checkIn 성공");
               response.setContentType("text/html; charset=UTF-8");
               out.println("<script>alert('출석체크 성공했습니다.'); location.href='home.student';</script>");
               out.flush();
            }
            else {
               System.out.println("checkIn test location_Longitude");
            }
         }
         else {
            System.out.println("checkIn test location_Latitude");
         }
      }
      else {
         System.out.println("checkIn test IP");
      }
      mav.addObject("alertMessage", "해당위치에서 출석할 수 없습니다.");
      mav.setViewName(getPage);
      return mav;
      /*
       response.setContentType("text/html; charset=UTF-8");
       out.println("<script>alert('해당위치에서 출석할 수 없습니다.');</script>"); 
       out.flush();
       mav.setViewName(getPage); return mav;
       */
   }

   @RequestMapping(value = finCommand, method = RequestMethod.GET)
   public String fin() {
      return gotoPage;
   }

   @RequestMapping(value = finCommand, method = RequestMethod.POST)
   public ModelAndView fin(
         @RequestParam(value = "mem_num", required = true) String mem_num,
         @RequestParam(value = "mem_ip", required = true) String mem_ip,
         @RequestParam(value = "mem_latitude", required = true) double mem_latitude,
         @RequestParam(value = "mem_longitude", required = true) double mem_longitude,
         HttpServletRequest request,
         HttpServletResponse response,
         HttpSession session) throws IOException, ParseException {

      System.out.println("DB(member) mem_num : " + mem_num);
      System.out.println("DB(member) mem_ip : " + mem_ip);
      System.out.println("DB(member) mem_latitude : " + mem_latitude);
      System.out.println("DB(member) mem_longitude : " + mem_longitude);

      ModelAndView mav = new ModelAndView();

      PrintWriter out = response.getWriter();

      String stuIp = request.getParameter("ipAddress");
      
      double stuLatitude = Double.parseDouble(request.getParameter("latitude"));
      double stuLongitude = Double.parseDouble(request.getParameter("longitude"));
      
      System.out.println("학생PC의 latitude(위도) : " + stuLatitude);
      System.out.println("학생PC의 longitude(경도) : " + stuLongitude);
      
      double MinLatitude = mem_latitude - 0.1;
      double MaxLatitude = mem_latitude + 0.1;
      double MinLongitude = mem_longitude - 0.02;
      double MaxLongitude = mem_longitude + 0.02;
      
      if (stuIp != null && stuIp.equals(mem_ip)) {   //IP가 같다면
         if (stuLatitude <= MaxLatitude && stuLatitude >= MinLatitude) {
            if (stuLongitude <= MaxLongitude && stuLongitude >= MinLongitude) {
               
               student.model.AttendBean ab2 = attendDao.getAttendPrimaryKey(mem_num, mem_ip);
               student.model.AttendBean ab = attendDao.getAttendListByAtt_num(ab2.getAtt_num());

               int cnt = attendDao.updateFdate(ab.getAtt_num());
               
               ab = attendDao.getAttendListByAtt_num(ab.getAtt_num());

               //수업시간(분)
               int time = attendDao.getRunningTime(ab.getAtt_num(), ab.getAtt_sdate(), ab.getAtt_fdate());
               
               System.out.println("Running time : " + time);

               String condition = null;
               
               // 정상출석
               if (time >= 520) {
                  condition = "attend";
               }
               // 결석
               else if (time < 220) {
                  condition = "absence";
               }
                // 지각, 조퇴 확인
               else {
                  int sdate = attendDao.transFormSdate(ab.getAtt_num(), ab.getAtt_sdate());
                  int fdate = attendDao.transFormFdate(ab.getAtt_num(), ab.getAtt_fdate());

                  if (sdate > 910) {      // 9:10분 이후에 오면 지각
                     condition = "late";
                  }
                  if (fdate < 1750) {      // 17:50:00 이전에 나가면 조퇴
                     if (condition == null || !condition.equals("late")) {
                        condition = "leave";
                     } 
                     else {
                        condition = "late";
                     }
                  }
               }

               if (condition != null) {
                  attendDao.updateSitu(ab.getAtt_num(), condition);
                  ab = attendDao.getAttendListByAtt_num(ab.getAtt_num());
                  System.out.println("test " + condition + " : " + ab.getSitu());
               }
               String check_flag = "";
               session.setAttribute("check_flag", check_flag);
               session.invalidate();
               System.out.println("checkOut 성공");
               
               mav.setViewName(checkOutPage);
               return mav;
               /*
               response.setContentType("text/html; charset=UTF-8");
               out.println("<script>alert('퇴실 정상처리됐습니다.'); location.href='login.in';</script>");
               out.flush();
                */
               
            }
            else {
               System.out.println("checkIn test location_Longitude");
            }
         }
         else {
            System.out.println("checkIn test location_Latitude");
         }
      }
      mav.addObject("alertMessage", "해당PC에서 퇴실 할 수 없습니다.");
      mav.setViewName(getPage);
      return mav;
   }
   
   @RequestMapping(value = startCommand2, method = RequestMethod.GET)
   public String start2() {
      return gotoPage2;
   }

   @RequestMapping(value = startCommand2, method = RequestMethod.POST)
   public ModelAndView start2(
         @RequestParam(value = "mem_num", required = true) String mem_num,
         @RequestParam(value = "mem_ip", required = true) String mem_ip,
         @RequestParam(value = "mem_latitude", required = true) double mem_latitude,
         @RequestParam(value = "mem_longitude", required = true) double mem_longitude,
         HttpServletRequest request,
         HttpServletResponse response,
         HttpSession session) throws IOException, ParseException {

      System.out.println("DB(member) mem_num : " + mem_num);
      System.out.println("DB(member) mem_ip : " + mem_ip);
      System.out.println("DB(member) mem_latitude : " + mem_latitude);
      System.out.println("DB(member) mem_longitude : " + mem_longitude);

      ModelAndView mav = new ModelAndView();

      PrintWriter out = response.getWriter();

      // 사용자(학생)의 IP 주소 가져오기
      String stuIp = request.getParameter("ipAddress");   //로그인한 PC의 IP 주소
      System.out.println("학생PC의 IP : " + stuIp);
      
      // 사용자(학생)의 '출석'한 위치 가져오기
      double stuLatitude = Double.parseDouble(request.getParameter("latitude"));
      double stuLongitude = Double.parseDouble(request.getParameter("longitude"));
      
      System.out.println("학생PC의 latitude(위도) : " + stuLatitude);
      System.out.println("학생PC의 longitude(경도) : " + stuLongitude);
      
      double MinLatitude = mem_latitude - 0.1;
      double MaxLatitude = mem_latitude + 0.1;
      double MinLongitude = mem_longitude - 0.02;
      double MaxLongitude = mem_longitude + 0.02;

      if (stuIp != null && stuIp.equals(mem_ip)) {   //IP가 같다면
         if (stuLatitude <= MaxLatitude && stuLatitude >= MinLatitude) {
            if (stuLongitude <= MaxLongitude && stuLongitude >= MinLongitude) {
               
               int cnt = attendDao.insertCheck(mem_num, mem_ip);

               AttendBean ab2 = attendDao.getAttendPrimaryKey(mem_num, mem_ip);
               AttendBean ab = attendDao.getAttendListByAtt_num(ab2.getAtt_num());
               System.out.println("Controller insert att_num: " + ab.getAtt_num());
               System.out.println("Controller getAttendListByAtt_num test : " + ab.getAtt_sdate());

               String check_flag = "success";
               session.setAttribute("check_flag", check_flag);
               
               SimpleDateFormat dateFormat = new SimpleDateFormat("HH시mm분");
               String sdate_string = dateFormat.format(ab.getAtt_sdate()); //날짜가 string으로 저장
               String fdate_string = null; // ab.getAtt_fdate() == null
               
               session.setAttribute("att_sdate", sdate_string);
               session.setAttribute("att_fdate", fdate_string);
               
               System.out.println("checkIn 성공");
               response.setContentType("text/html; charset=UTF-8");
               out.println("<script>alert('출석체크 성공했습니다.'); location.href='home.manager';</script>");
               out.flush();
            }
            else {
               System.out.println("checkIn test location_Longitude");
            }
         }
         else {
            System.out.println("checkIn test location_Latitude");
         }
      }
      else {
         System.out.println("checkIn test IP");
      }
      mav.addObject("alertMessage", "해당위치에서 출석할 수 없습니다.");
      mav.setViewName(getPage2);
      return mav;
      /*
       response.setContentType("text/html; charset=UTF-8");
       out.println("<script>alert('해당위치에서 출석할 수 없습니다.');</script>"); 
       out.flush();
       mav.setViewName(getPage); return mav;
       */
   }

   @RequestMapping(value = finCommand2, method = RequestMethod.GET)
   public String fin2() {
      return gotoPage2;
   }

   @RequestMapping(value = finCommand2, method = RequestMethod.POST)
   public ModelAndView fin2(
         @RequestParam(value = "mem_num", required = true) String mem_num,
         @RequestParam(value = "mem_ip", required = true) String mem_ip,
         @RequestParam(value = "mem_latitude", required = true) double mem_latitude,
         @RequestParam(value = "mem_longitude", required = true) double mem_longitude,
         HttpServletRequest request,
         HttpServletResponse response,
         HttpSession session) throws IOException, ParseException {

      System.out.println("DB(member) mem_num : " + mem_num);
      System.out.println("DB(member) mem_ip : " + mem_ip);
      System.out.println("DB(member) mem_latitude : " + mem_latitude);
      System.out.println("DB(member) mem_longitude : " + mem_longitude);

      ModelAndView mav = new ModelAndView();

      PrintWriter out = response.getWriter();

      String stuIp = request.getParameter("ipAddress");
      
      double stuLatitude = Double.parseDouble(request.getParameter("latitude"));
      double stuLongitude = Double.parseDouble(request.getParameter("longitude"));
      
      System.out.println("학생PC의 latitude(위도) : " + stuLatitude);
      System.out.println("학생PC의 longitude(경도) : " + stuLongitude);
      
      double MinLatitude = mem_latitude - 0.1;
      double MaxLatitude = mem_latitude + 0.1;
      double MinLongitude = mem_longitude - 0.02;
      double MaxLongitude = mem_longitude + 0.02;
      
      if (stuIp != null && stuIp.equals(mem_ip)) {   //IP가 같다면
         if (stuLatitude <= MaxLatitude && stuLatitude >= MinLatitude) {
            if (stuLongitude <= MaxLongitude && stuLongitude >= MinLongitude) {
               
               student.model.AttendBean ab2 = attendDao.getAttendPrimaryKey(mem_num, mem_ip);
               student.model.AttendBean ab = attendDao.getAttendListByAtt_num(ab2.getAtt_num());

               int cnt = attendDao.updateFdate(ab.getAtt_num());
               
               ab = attendDao.getAttendListByAtt_num(ab.getAtt_num());

               //수업시간(분)
               int time = attendDao.getRunningTime(ab.getAtt_num(), ab.getAtt_sdate(), ab.getAtt_fdate());
               
               System.out.println("Running time : " + time);

               String condition = null;
               
               // 정상출석
               if (time >= 520) {
                  condition = "attend";
               }
               // 결석
               else if (time < 220) {
                  condition = "absence";
               }
                // 지각, 조퇴 확인
               else {
                  int sdate = attendDao.transFormSdate(ab.getAtt_num(), ab.getAtt_sdate());
                  int fdate = attendDao.transFormFdate(ab.getAtt_num(), ab.getAtt_fdate());

                  if (sdate > 910) {      // 9:10분 이후에 오면 지각
                     condition = "late";
                  }
                  if (fdate < 1750) {      // 17:50:00 이전에 나가면 조퇴
                     if (condition == null || !condition.equals("late")) {
                        condition = "leave";
                     } 
                     else {
                        condition = "late";
                     }
                  }
               }

               if (condition != null) {
                  attendDao.updateSitu(ab.getAtt_num(), condition);
                  ab = attendDao.getAttendListByAtt_num(ab.getAtt_num());
                  System.out.println("test " + condition + " : " + ab.getSitu());
               }
               String check_flag = "";
               session.setAttribute("check_flag", check_flag);
               session.invalidate();
               System.out.println("checkOut 성공");
               
               mav.setViewName(checkOutPage2);
               return mav;
               /*
               response.setContentType("text/html; charset=UTF-8");
               out.println("<script>alert('퇴실 정상처리됐습니다.'); location.href='login.in';</script>");
               out.flush();
                */
               
            }
            else {
               System.out.println("checkIn test location_Longitude");
            }
         }
         else {
            System.out.println("checkIn test location_Latitude");
         }
      }
      mav.addObject("alertMessage", "해당PC에서 퇴실 할 수 없습니다.");
      mav.setViewName(getPage2);
      return mav;
   }
}