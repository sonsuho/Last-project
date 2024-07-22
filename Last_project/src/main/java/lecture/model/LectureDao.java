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
	
	public int deleteLecture(int lec_num) {
		int cnt = -1;
		cnt = sqlSessionTemplate.delete(namespace+".deleteLecture", lec_num);
		return cnt;
	}
	
	public List<LectureBean> getLectureByMemNum(int mem_num) {
		List<LectureBean> lectures = new ArrayList<LectureBean>();
		lectures = sqlSessionTemplate.selectList(namespace+".getLectureByMemNum", mem_num);
		System.out.println(mem_num + "번 회원의 lectures.size() : " + lectures.size());
		return lectures;
	}
	
	public String getClassNameByLec(String lec_num) {
		
		String className = sqlSessionTemplate.selectOne("lecture.model.Lecture.getClassNameByLec", lec_num);
		
		System.out.println("getClassNameByLec name : " + className);
		
		return className;
	}
	
	public int updateLecture(LectureBean lecture) {
		int cnt = -1;
		System.out.println("updateLecture");
		System.out.println("manager/teacher :" + lecture.getManager()+"/"+lecture.getTeacher());
		System.out.println("m_name/t_name :" + lecture.getM_name()+"/"+lecture.getT_name());
		cnt = sqlSessionTemplate.update(namespace+".updateLecture", lecture);
		return cnt;
	}


	//민곤
	public void deleteManagerFromLecture(int lec_num, int oldManager) {
		LectureBean lb = new LectureBean();
		lb.setLec_num(lec_num);
		lb.setManager(oldManager);
		sqlSessionTemplate.delete(namespace+".deleteManagerFromLecture",lb);
		
	}

	public void deleteTeacherFromLecture(int lec_num, int oldTeacher) {
		LectureBean lb = new LectureBean();
		lb.setLec_num(lec_num);
		lb.setTeacher(oldTeacher);
		
		sqlSessionTemplate.delete(namespace+".deleteTeacherFromLecture",lb);
	}
	
	//민곤
	
	public List<LectureBean> getLectureForManager(int mem_num) {
		List<LectureBean> lectures = new ArrayList<LectureBean>();
		lectures = sqlSessionTemplate.selectList(namespace+".getLectureForManager", mem_num);
		System.out.println(mem_num + "번 회원의 lectures.size() : " + lectures.size());
		return lectures;
	}
	
	public LectureBean getLectureByClass(String class_name) {
		LectureBean lb = new LectureBean();
		int cnt = 0;
		lb = sqlSessionTemplate.selectOne(namespace+".getLectureByClass1", class_name);
		if(lb==null) {
			cnt++;
			lb = sqlSessionTemplate.selectOne(namespace+".getLectureByClass2", class_name);
			if(lb==null) {
				cnt++;
				lb = sqlSessionTemplate.selectOne(namespace+".getLectureByClass3", class_name);
			} else {
				System.out.println(class_name + "반 : 예정");
			}
		} else {
			System.out.println(class_name + "반 : 진행");
		}
		System.out.println("getLectureByClass cnt : " + cnt);
		return lb;
	}
	
	public LectureBean getLectureForTeacher(int mem_num) {
		LectureBean lb = new LectureBean();
		lb = sqlSessionTemplate.selectOne(namespace+".getLectureForTeacher", mem_num);
		return lb; 
	}
}

