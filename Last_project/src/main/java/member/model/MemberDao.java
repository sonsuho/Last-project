package member.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import utility.Paging;

@Controller
public class MemberDao {

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	private String namespace = "member.model.Member";
	
	public List<MemberBean> getMemberByCate(String category){
		List<MemberBean> list = new ArrayList<MemberBean>();
		list = sqlSessionTemplate.selectList(namespace+".getMemberByCate", category);
		return list;
	} //getMemberByCate
	
	public void idInsert(MemberBean mb) {
		sqlSessionTemplate.update(namespace+".idInsert", mb);
	} //idInsert
	
	public List<MemberBean> getEmplList(Paging pageInfo, Map<String,String> map){
		RowBounds rowbounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		List<MemberBean> list = new ArrayList<MemberBean>();
		list = sqlSessionTemplate.selectList(namespace+".getEmplList", map, rowbounds);
		return list;
	} //getEmplList
	
	public int getTotalEmpl(Map<String,String> map) {
		int totalCount = -1;
		totalCount = sqlSessionTemplate.selectOne(namespace+".getTotalEmpl", map);
		return totalCount;
	} //getTotalEmpl
	
	public String getPwByNum(int mem_num) {
		String pw = sqlSessionTemplate.selectOne(namespace+".getPwByNum", mem_num);
		return pw;
	} //getPwByNum
	
	public int idDelete(int mem_num) {
		int cnt = -1;
		cnt = sqlSessionTemplate.delete(namespace+".idDelete", mem_num);
		return cnt;
	} //idDelete
	
	public int findPw(MemberBean mb) {
		int mem_num = -1;
		System.out.println("아이디 : " + mb.getId());
		System.out.println("전화번호 : " + mb.getPhone());
		
		Object result = sqlSessionTemplate.selectOne(namespace+".findPw", mb);
		if(result != null) {
			mem_num = (Integer)result;
		}
		System.out.println("비밀번호찾기 회원번호 : " + mem_num);
		return mem_num;
	}
	
	public int changePw(MemberBean mb) {
		int cnt = -1;
		cnt = sqlSessionTemplate.update(namespace+".changePw",mb);
		return cnt;
	}
	
	// 민곤
	public MemberBean getNameByNum(int mem_num) {
		System.out.println("넘어온 받는회원번호:"+mem_num);
		MemberBean mb = sqlSessionTemplate.selectOne(namespace+".getNameByNum", mem_num);
		System.out.println("출력이름:"+mb.getName());
		return mb;
	}

	public MemberBean getNameBySendNum(int sender_num) {
		System.out.println("넘어온 보내는회원번호:"+sender_num);
		MemberBean mb = sqlSessionTemplate.selectOne(namespace+".getNameBySendNum", sender_num);
		System.out.println("출력이름:"+mb.getName());
		return mb;
	}
	
	// 수진
	/* member 회원 테이블 */
	public List<MemberBean> getMemberByNum(int[] num_arr){
		
		List<MemberBean> list = new ArrayList<MemberBean>();
		for(int mem_num : num_arr) {
			
			MemberBean memberBean = sqlSessionTemplate.selectOne(namespace+".getMemberByNum", mem_num);
			list.add(memberBean);
		}
		
		return list;
	}

	public List<MemberBean> getStudentByLecNum(int lec_num){
		List<MemberBean> members = new ArrayList<MemberBean>();
		members = sqlSessionTemplate.selectList(namespace+".getStudentByLecNum", lec_num);
		return members;
	}
	
	public int updateLecNum(Map<String,String> map) {
		int cnt = -1;
		cnt = sqlSessionTemplate.update(namespace+".updateLecNum", map);
		return cnt;
	}
	
	public int getStudent(int lec_num) {
		int cnt = -1;
		System.out.println("getStudent lec_num : " + lec_num);
		cnt = sqlSessionTemplate.selectOne(namespace+".getStudent", lec_num);
		return cnt;
	}
	
	public int changePhone(MemberBean mb) {
		System.out.println("changePhone Dao");
		int cnt = -1;
		cnt = sqlSessionTemplate.update(namespace+".changePhone",mb);
		return cnt;
	}
}
