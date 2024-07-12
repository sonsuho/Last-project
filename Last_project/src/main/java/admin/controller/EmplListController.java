package admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;
import member.model.MemberDao;
import utility.Paging;

@Controller
public class EmplListController {

	private final String command = "emplList.admin";
	private final String getPage = "emplList";
	
	@Autowired
	MemberDao mdao;
	
	@RequestMapping(command)
	public String emplList(Model model, HttpServletRequest request,
						   @RequestParam(value="pageNumber", required=false) String pageNumber,
						   @RequestParam(value="whatColumn", required=false) String whatColumn,
						   @RequestParam(value="keyword", required=false) String keyword) {
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("whatColumn", whatColumn);
		map.put("keyword", "%"+keyword+"%");
		
		String url = request.getContextPath()+"/"+command;
		int totalCount = mdao.getTotalEmpl(map);
		Paging pageInfo = new Paging(pageNumber,"5",totalCount,url,whatColumn,keyword);
		
		List<MemberBean> emplList = mdao.getEmplList(pageInfo, map); 
		model.addAttribute("emplList",emplList);
		model.addAttribute("pageInfo",pageInfo);
		
		return getPage;
	}
	
}
