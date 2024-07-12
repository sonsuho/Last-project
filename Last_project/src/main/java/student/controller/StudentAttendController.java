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

import member.model.AttendBean;
import student.model.StudentAttendDao;

@Controller
public class StudentAttendController {

    private final String startCommand = "/start.student";
    private final String finCommand = "/fin.student";

    final String getPage = "home";  // 학생 홈 페이지
    final String gotoPage = "redirect:/home.student";  // 홈 페이지로 리디렉션
    final String checkOutPage = "redirect:/login.in";  // 로그인 페이지로 리디렉션
    final String failPage = "/home.student";  // 실패 시 홈 페이지

    @Autowired
    StudentAttendDao sattendDao;

    @RequestMapping(value = startCommand, method = RequestMethod.POST)
    public ModelAndView start(
            @RequestParam(value = "mem_num", required = false) String mem_num,
            @RequestParam(value = "mem_ip", required = false) String mem_ip,
            @RequestParam(value = "mem_latitude", required = false) double mem_latitude,
            @RequestParam(value = "mem_longitude", required = false) double mem_longitude,
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
        String stuIp = request.getParameter("ipAddress");
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

        if (stuIp != null && stuIp.equals(mem_ip)) {   // IP가 같다면
            if (stuLatitude <= MaxLatitude && stuLatitude >= MinLatitude) {
                if (stuLongitude <= MaxLongitude && stuLongitude >= MinLongitude) {

                    int cnt = sattendDao.insertCheck(mem_num, mem_ip);

                    AttendBean ab2 = sattendDao.getAttendPrimaryKey(mem_num, mem_ip);
                    AttendBean ab = sattendDao.getAttendListByAtt_num(ab2.getAtt_num());
                    System.out.println("Controller insert att_num: " + ab.getAtt_num());
                    System.out.println("Controller getAttendListByAtt_num test : " + ab.getAtt_sdate());

                    session.setAttribute("check_flag", "success");

                    SimpleDateFormat dateFormat = new SimpleDateFormat("HH시mm분");
                    String sdate_string = dateFormat.format(ab.getAtt_sdate());
                    String fdate_string = null;

                    session.setAttribute("att_sdate", sdate_string);
                    session.setAttribute("att_fdate", fdate_string);
                    session.setAttribute("situ", ab.getSitu());

                    System.out.println("checkIn 성공");
                    response.setContentType("text/html; charset=UTF-8");
                    out.println("<script>alert('출석체크 성공했습니다.'); location.href='home.student';</script>");
                    out.flush();
                } else {
                    System.out.println("checkIn test location_Longitude");
                    response.setContentType("text/html; charset=UTF-8");
                    out.println("<script>alert('해당 위치에서 출석할 수 없습니다.'); location.href='home.student';</script>");
                    out.flush();
                }
            } else {
                response.setContentType("text/html; charset=UTF-8");
                out.println("<script>alert('해당 위치에서 출석할 수 없습니다.');location.href='home.student';</script>");
                out.flush();
            }
        } else {
            System.out.println("checkIn test IP");
            response.setContentType("text/html; charset=UTF-8");
            out.println("<script>alert('해당 PC에서 출석할 수 없습니다.');</script>");
            out.flush();
        }
        mav.setViewName(getPage);
        return mav;
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

        if (stuIp != null && stuIp.equals(mem_ip)) {   // IP가 같다면
            if (stuLatitude <= MaxLatitude && stuLatitude >= MinLatitude) {
                if (stuLongitude <= MaxLongitude && stuLongitude >= MinLongitude) {

                    AttendBean ab2 = sattendDao.getAttendPrimaryKey(mem_num, mem_ip);
                    AttendBean ab = sattendDao.getAttendListByAtt_num(ab2.getAtt_num());

                    int cnt = sattendDao.updateFdate(ab.getAtt_num());

                    ab = sattendDao.getAttendListByAtt_num(ab.getAtt_num());

                    // 수업시간(분)
                    int time = sattendDao.getRunningTime(ab.getAtt_num(), ab.getAtt_sdate(), ab.getAtt_fdate());
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
						int sdate = sattendDao.transFormSdate(ab.getAtt_num(), ab.getAtt_sdate());
						int fdate = sattendDao.transFormFdate(ab.getAtt_num(), ab.getAtt_fdate());

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
						sattendDao.updateSitu(ab.getAtt_num(), condition);
						ab = sattendDao.getAttendListByAtt_num(ab.getAtt_num());
						System.out.println("test " + condition + " : " + ab.getSitu());
					}

					String check_flag = "";
					session.setAttribute("check_flag", check_flag);
					session.invalidate();
					System.out.println("checkOut 성공");

					mav.setViewName(checkOutPage);
					return mav;
					
                } else {
                    System.out.println("checkOut test location_Longitude");
                    response.setContentType("text/html; charset=UTF-8");
                    out.println("<script>alert('해당 위치에서 퇴실할 수 없습니다.'); location.href='home.student';</script>");
                    out.flush();
                }
            } else {
                response.setContentType("text/html; charset=UTF-8");
                out.println("<script>alert('해당 위치에서 퇴실할 수 없습니다.'); location.href='home.student';</script>");
                out.flush();
            }
        } else {
            System.out.println("checkOut test IP");
            response.setContentType("text/html; charset=UTF-8");
            out.println("<script>alert('해당 PC에서 퇴실할 수 없습니다.');</script>");
            out.flush();
        }
        mav.setViewName(getPage);
        return mav;
    }
}
