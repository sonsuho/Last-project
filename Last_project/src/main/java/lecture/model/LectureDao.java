package lecture.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import utility.Paging;

@Component
public class LectureDao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public LectureDao() {
		System.out.println("LectureDao 생성자 생성");
	}

	private String namespace = "lecture.model.Lecture";
	
	public List<LectureBean> getLectureList(Paging pageInfo, Map<String,String> map){
		RowBounds rowbounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		List<LectureBean> list = new ArrayList<LectureBean>();
		list = sqlSessionTemplate.selectList(namespace+".getLectureList", map, rowbounds);
		return list;
	} //getLectureList
	
	public int getTotalLecture(Map<String,String> map) {
		int totalCount = -1;
		totalCount = sqlSessionTemplate.selectOne(namespace+".getTotalLecture", map);
		return totalCount;
	} //getTotalLecture
	
	public int insertLecture(LectureBean lecture) {
		int cnt = -1;
		cnt = sqlSessionTemplate.insert(namespace+".insertLecture", lecture);
		System.out.println("insertLecture cnt : " + cnt);
		return cnt;
	} //insertLecture
	
	public LectureBean getLectureByNum(int lec_num){
		LectureBean lecture = sqlSessionTemplate.selectOne(namespace+".getLectureByNum", lec_num);
		return lecture;
	} //getLectureByNum
	
	public String getClassNameByLec(String lec_num) {
		
		String className = sqlSessionTemplate.selectOne("lecture.model.Lecture.getClassNameByLec", lec_num);
		
		System.out.println("getClassNameByLec name : " + className);
		
		return className;
	}
	
}
