package admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberDao;

@Controller
public class IdDeleteController {

	private final String command = "idDelete.admin";
	private final String gotoPage = "redirect:/emplList.admin";
	
	@Autowired
	MemberDao mdao;
	
	// 여러개 선택 삭제
	@RequestMapping(value=command, method=RequestMethod.POST)
	public String idDelete(@RequestParam("rowcheck") int[] rowcheck,
						   @RequestParam(value="pageNumber",required=false) String pageNumber,
						   @RequestParam(value="whatColumn",required=false) String whatColumn,
						   @RequestParam(value="keyword",required=false) String keyword,
						   Model model) {
		
		model.addAttribute("pageNumber",pageNumber);
		model.addAttribute("whatColumn",whatColumn);
		model.addAttribute("keyword",keyword);
		
		for(int mem_num : rowcheck) {			
			mdao.idDelete(mem_num);
		}
		
		return gotoPage;
	}
	
}
