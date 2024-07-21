package student.model;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import member.model.AttendBean;

@Repository
@Component
public class StudentAttendDao {

    private String namespace = "student.model.Student";

    @Autowired
    SqlSessionTemplate sqlSessionTemplate;

    public StudentAttendDao() {
        System.out.println("StudentAttendDao 생성자");
    }

    public AttendBean getAttendPrimaryKey(String mem_num, String mem_ip) {
    	System.out.println("StudentAttendDao getAttendPrimaryKey");
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("mem_num", mem_num);
        map.put("mem_ip", mem_ip);
        return sqlSessionTemplate.selectOne(namespace + ".getAttendPrimaryKey", map);
    }

    public AttendBean getAttendListByAtt_num(int att_num) {
    	System.out.println("StudentAttendDao getAttendListByAtt_num");
        return sqlSessionTemplate.selectOne(namespace + ".getAttendListByAtt_num", att_num);
    }

    public int insertCheck(String mem_num, String mem_ip) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("mem_num", mem_num);
        map.put("mem_ip", mem_ip);
        System.out.println("StudentAttendDao insertCheck");
        return sqlSessionTemplate.insert(namespace + ".insertCheck", map);
    }

    public int updateFdate(int att_num) {
    	System.out.println("StudentAttendDao updateFdate");
        return sqlSessionTemplate.update(namespace + ".updateFdate", att_num);
    }

    public int getRunningTime(int att_num, Date att_sdate, Date att_fdate) {
    	System.out.println("Dao로 넘어온 att_sdate : " + att_sdate);
    	System.out.println("Dao로 넘어온 att_fdate : " + att_fdate);
    	//Dao로 넘어온 new_sdate : 2024-07-02 08:53:03.0
    	//Dao로 넘어온 new_fdate : 2024-07-02 08:53:08.0
    	
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("att_num", att_num);
        map.put("att_sdate", att_sdate);
        map.put("att_fdate", att_fdate);
        return sqlSessionTemplate.selectOne(namespace + ".getRunningTime", map);
    }

    public int transFormSdate(int att_num, Date new_sdate) {
    	System.out.println("StudentAttendDao transFormSdate");
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("att_num", att_num);
        map.put("new_sdate", new_sdate);
        return sqlSessionTemplate.selectOne(namespace + ".transFormSdate", map);
    }

    public int transFormFdate(int att_num, Date new_fdate) {
    	System.out.println("StudentAttendDao transFormFdate");
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("att_num", att_num);
        map.put("new_fdate", new_fdate);
        return sqlSessionTemplate.selectOne(namespace + ".transFormFdate", map);
    }

    public void updateSitu(int att_num, String condition) {		//상태 수정(출석, 결석, 지각, 조퇴)
    	System.out.println("StudentAttendDao updateSitu");
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("att_num", att_num);
        map.put("condition", condition);
        sqlSessionTemplate.update(namespace + ".updateSitu", map);
    }

	public List<AttendBean> getAttendListByMem_num(String mem_num) {
		
		List<AttendBean> lists = new ArrayList<AttendBean>();
		lists = sqlSessionTemplate.selectList(namespace + ".getAttendListByMem_num", mem_num);
		return lists;
	}
}