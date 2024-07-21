package student.model;

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

	public List<MemberBean> getStudentByLec_Num(String lec_Num) {			// 
		
		List<MemberBean> slist = sqlSessionTemplate.selectList("student.model.Student.getStudentByLec_Num", lec_Num);
		
		System.out.println("slist 사이즈 : " + slist.size());
		
		return slist;
	}

	

	public MemberBean getStudentByMem_Num(int stu_num) {
		
		MemberBean student = sqlSessionTemplate.selectOne("student.model.Student.getStudentByMem_Num", stu_num);
		
		System.out.println("getStudentByMem_Num 이름 : " + student.getName());
		
		return student;
	}
	
	
}
