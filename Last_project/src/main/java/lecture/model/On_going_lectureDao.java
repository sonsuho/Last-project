package lecture.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class On_going_lectureDao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public On_going_lectureDao() {
		System.out.println("On_going_lectureDao 생성자 생성");
	}

	public int updateOngoingLecture(On_going_lectureBean ob) {
		
		int cnt = -1;
		
		cnt = sqlSessionTemplate.update("lecture.model.Lecture.updateOngoingLecture", ob);
		
		System.out.println("updateOngoingLecture cnt : " + cnt);
		
		return cnt;
	}

	public On_going_lectureBean getLectureByLec(String lec_num) {
		
		On_going_lectureBean lecture = sqlSessionTemplate.selectOne("lecture.model.Lecture.getLectureByLec", lec_num);
		
		System.out.println("getLectureByLec lecture state : " + lecture.getOnoff());
		
		return lecture;
	}
	
	
}
