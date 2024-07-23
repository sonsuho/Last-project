package student.model;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import member.model.MemberBean;

@Component(value = "student")
public class StudentDao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public StudentDao() {
		System.out.println("StudentDao 생성자 생성");
	}

	public List<MemberBean> getStudentByLec_Num(String lec_Num) {
	    // 쉼표로 구분된 lec_Num을 분리하여 배열로 변환
	    String[] lecNums = lec_Num.split(",");
	    
	    // 결과를 담을 리스트
	    List<MemberBean> slist = new ArrayList<MemberBean>();

	    // 각 lec_num에 대해 DB 쿼리 수행
	    for (String num : lecNums) {
	        List<MemberBean> result = sqlSessionTemplate.selectList("student.model.Student.getStudentByLec_Num", num.trim());
	        slist.addAll(result);
	    }

	    System.out.println("slist 사이즈 : " + slist.size());
	    
	    return slist;
	}

	

	public MemberBean getStudentByMem_Num(int stu_num) {
		
		MemberBean student = sqlSessionTemplate.selectOne("student.model.Student.getStudentByMem_Num", stu_num);
		
		System.out.println("getStudentByMem_Num 이름 : " + student.getName());
		
		return student;
	}
	
	
}
