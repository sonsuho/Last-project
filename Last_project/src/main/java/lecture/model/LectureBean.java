package lecture.model;

public class LectureBean {

	private int lec_num;
	private String lec_name;
	private int teacher;
	private int manager;
	private String lec_start;
	private String lec_end;
	private int stu_cnt;
	private String class_name;
	
	private int student; // 현재 등록된 학생수
	private String m_name;	// 매니저 이름
	private String t_name;	// 강사 이름
	private String m_phone; // 매니저 전화번호
	private String t_phone; // 강사 전화번호
	private String m_email; // 매니저 이메일
	private String t_email; // 강사 이메일
	private String m_gender; // 매니저 성별
	private String t_gender; // 강사 성별
	private int m_age; // 매니저 나이
	private int t_age; // 강사 나이
	
	public String getM_name() {
		return m_name;
	}
	public void setM_name(String m_name) {
		this.m_name = m_name;
	}
	public String getT_name() {
		return t_name;
	}
	public void setT_name(String t_name) {
		this.t_name = t_name;
	}
	
	public String getM_phone() {
		return m_phone;
	}
	public void setM_phone(String m_phone) {
		this.m_phone = m_phone;
	}
	public String getT_phone() {
		return t_phone;
	}
	public void setT_phone(String t_phone) {
		this.t_phone = t_phone;
	}
	public String getM_email() {
		return m_email;
	}
	public void setM_email(String m_email) {
		this.m_email = m_email;
	}
	public String getT_email() {
		return t_email;
	}
	public void setT_email(String t_email) {
		this.t_email = t_email;
	}
	public int getStudent() {
		return student;
	}
	public void setStudent(int student) {
		this.student = student;
	}
	public int getLec_num() {
		return lec_num;
	}
	public void setLec_num(int lec_num) {
		this.lec_num = lec_num;
	}
	public String getLec_name() {
		return lec_name;
	}
	public void setLec_name(String lec_name) {
		this.lec_name = lec_name;
	}
	public int getTeacher() {
		return teacher;
	}
	public void setTeacher(int teacher) {
		this.teacher = teacher;
	}
	public int getManager() {
		return manager;
	}
	public void setManager(int manager) {
		this.manager = manager;
	}
	public String getLec_start() {
		return lec_start;
	}
	public void setLec_start(String lec_start) {
		this.lec_start = lec_start;
	}
	public String getLec_end() {
		return lec_end;
	}
	public void setLec_end(String lec_end) {
		this.lec_end = lec_end;
	}
	public int getStu_cnt() {
		return stu_cnt;
	}
	public void setStu_cnt(int stu_cnt) {
		this.stu_cnt = stu_cnt;
	}
	public String getClass_name() {
		return class_name;
	}
	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}
	public String getM_gender() {
		return m_gender;
	}
	public void setM_gender(String m_gender) {
		this.m_gender = m_gender;
	}
	public String getT_gender() {
		return t_gender;
	}
	public void setT_gender(String t_gender) {
		this.t_gender = t_gender;
	}
	public int getM_age() {
		return m_age;
	}
	public void setM_age(int m_age) {
		this.m_age = m_age;
	}
	public int getT_age() {
		return t_age;
	}
	public void setT_age(int t_age) {
		this.t_age = t_age;
	}
	
}
