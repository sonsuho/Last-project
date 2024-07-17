package admin.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import alarm.model.AlarmService;
import lecture.model.LectureBean;
import lecture.model.LectureDao;

@Controller
public class LectureDeleteController {

    private final String command = "lectureDelete.admin";
    private final String gotoPage = "redirect:/lectureList.admin";
    
    @Autowired
    LectureDao ldao;
    
    @Autowired
    AlarmService service;
    
    // 여러개 선택 삭제
    @RequestMapping(value=command, method=RequestMethod.POST)
    public String idDelete(@RequestParam("rowcheck") int [] rowcheck,
                           @RequestParam(value="pageNumber",required=false) String pageNumber,
                           @RequestParam(value="whatColumn",required=false) String whatColumn,
                           @RequestParam(value="keyword",required=false) String keyword,
                           Model model, HttpSession session, Map<String,String> paramap) {
        
        model.addAttribute("pageNumber",pageNumber);
        model.addAttribute("whatColumn",whatColumn);
        model.addAttribute("keyword",keyword);
        
        
        for (int lec_num : rowcheck) {
        	System.out.println("lec_num:"+lec_num);
        	LectureBean lb = ldao.getLectureByNum(lec_num);
        	System.out.println("lb.getLec_name():"+lb.getLec_name());
            int cnt = ldao.deleteLecture(lec_num); 
            System.out.println("cnt:"+cnt);
            if (cnt != -1) {
                    // 매니저에 대한 알림 생성
                    String managerId = String.valueOf(lb.getManager());
                    String lecName = lb.getLec_name();
                    
                    paramap.put("fk_recipientno", managerId);
                    paramap.put("url", "/lectureList");
                    paramap.put("url2", ".manager");
                    paramap.put("alarm_content", lecName + " 강좌가 삭제되었습니다.");
                    paramap.put("alarm_type", "2");
                    
                    service.addAlarm(paramap);
                    
                    // 강사에 대한 알림 생성
                    String teacherId = String.valueOf(lb.getTeacher());
                    
                    paramap.put("fk_recipientno", teacherId);
                    paramap.put("url", "/lectureList");
                    paramap.put("url2", ".teacher");
                    paramap.put("alarm_content", lecName + " 강좌가 삭제되었습니다.");
                    paramap.put("alarm_type", "2");
                    
                    service.addAlarm(paramap);
            }
        }
        
        return gotoPage;
    }

}
