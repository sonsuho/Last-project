package admin.controller;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Period;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thoughtworks.qdox.parser.ParseException;

import lecture.model.DetailBean;
import lecture.model.LectureBean;
import lecture.model.LectureDao;
import member.model.MemberBean;
import member.model.MemberDao;

@Controller
public class LectureDetailController {

	private final String command = "lectureDetail.admin";
	
	@Autowired
	LectureDao ldao;
	
	@Autowired
	MemberDao mdao;
	
	@RequestMapping(value=command, method=RequestMethod.POST)
	@ResponseBody
	public DetailBean detail(@RequestParam("lec_num") int lec_num) throws java.text.ParseException {
		
		System.out.println("lectureDetail.admin POST 요청");
		
		DetailBean db = new DetailBean();

		LectureBean lb = ldao.getLectureByNum(lec_num);
		List<MemberBean> members = mdao.getStudentByLecNum(lec_num); 
		
		MemberBean manager = mdao.getNameByNum(lb.getManager());
		lb.setM_name(manager.getName());
		lb.setM_phone(manager.getPhone());
		lb.setM_email(manager.getEmail());
		lb.setM_gender(manager.getGender());
		Date managerBirthDate = parseDate(manager.getBirth());
        int managerAge = calculateAge(managerBirthDate);
        System.out.println("매니저의 나이: " + managerAge + "세");
        lb.setM_age(managerAge);
		
		MemberBean teacher = mdao.getNameByNum(lb.getTeacher());
		lb.setT_name(teacher.getName());
		lb.setT_phone(teacher.getPhone());
		lb.setT_email(teacher.getEmail());
		lb.setT_gender(teacher.getGender());
		Date teacherBirthDate = parseDate(teacher.getBirth());
        int teacherAge = calculateAge(teacherBirthDate);
        System.out.println("강사의 나이: " + teacherAge + "세");
        lb.setT_age(teacherAge);
		
		db.setLecture(lb);
		db.setMembers(members);
		
		System.out.println("돌아갑니다...");
		
		return db;
	}
	
	public static int calculateAge(Date birthDate) {
        LocalDate birthLocalDate = birthDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
        LocalDate currentLocalDate = LocalDate.now();

        Period period = Period.between(birthLocalDate, currentLocalDate);
        int age = period.getYears();

        // 생일이 지나지 않았다면 나이에서 1 빼기
        if (currentLocalDate.getMonthValue() < birthLocalDate.getMonthValue() ||
            (currentLocalDate.getMonthValue() == birthLocalDate.getMonthValue() && currentLocalDate.getDayOfMonth() < birthLocalDate.getDayOfMonth())) {
            age--;
        }

        return age;
    }
	
	public static Date parseDate(String dateStr) throws java.text.ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            return sdf.parse(dateStr);
        } catch (ParseException e) {
            throw new RuntimeException("Invalid date format: " + dateStr, e);
        }
    }
	
}
