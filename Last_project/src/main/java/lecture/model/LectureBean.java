package lecture.model;

public class LectureBean {
	
	private int lec_num;
	private String lec_name;
	private String teacher;
	private String manager;
	private String lec_start;
	private String lec_end;
	private int stu_cnt;
	private String class_name;
	
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
	
	public String getTeacher() {
		return teacher;
	}
	public void setTeacher(String teacher) {
		this.teacher = teacher;
	}
	
	public String getManager() {
		return manager;
	}
	public void setManager(String manager) {
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
}
