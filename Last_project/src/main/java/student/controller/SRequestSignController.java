package student.controller;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import student.model.SRequestDao;

@Controller
public class SRequestSignController {
	
	private final String command = "signSave.student";
	private final String command2 = "signSave.manager";
	
	@Autowired
	SRequestDao requestDao;
	
	@RequestMapping(command)
	public String sign() {
		
		
		return "save";
	}
	
	@RequestMapping(command2)
	public String sign2() {
		
		
		return "save";
	}
	
}
