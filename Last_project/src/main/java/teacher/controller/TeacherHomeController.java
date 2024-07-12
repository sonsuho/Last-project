package teacher.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import teacher.model.TeacherDao;

@Controller
public class TeacherHomeController {
	
	final String command = "/home.teacher";
	final String getPage = "home";
	
	@Autowired
	TeacherDao tdao;
	
	@RequestMapping(command)
	public String home() {
		return getPage;
	}
	
}
