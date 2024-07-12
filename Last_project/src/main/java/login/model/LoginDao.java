package login.model;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import member.model.MemberBean;

@Component
public class LoginDao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public LoginDao() {
		System.out.println("LoginDao 생성");
	}

	public MemberBean getInfoById(String id) {
		
		MemberBean mb = sqlSessionTemplate.selectOne("login.model.Login.getInfoById", id);
		
		if(mb != null) {
			System.out.println("getInfoById mb 아이디 : " + mb.getId());
			System.out.println("getInfoById mb 카테고리 : "+mb.getCategory());
		}
		
		return mb;
	}
	
	public List<MemberBean> getInfoListByCategory(String category) {
		
		List<MemberBean> list = new ArrayList<MemberBean>();
		
		list = sqlSessionTemplate.selectList("login.model.Login.getInfoListByCategory", category);
		
		return list;
	}

}
