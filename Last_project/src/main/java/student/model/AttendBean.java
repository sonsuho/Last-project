package student.model;

import java.sql.Date;

public class AttendBean {

	private int att_num;
	private int mem_num;
	private String day;
	private Date att_sdate;
	private Date att_fdate;
	private int study_time;
	private String situ;
	private String ip;
	private double latitude;	//위도
	private double longitude;	//경도

	public AttendBean() {

	}

	public AttendBean(int att_num, int mem_num, String day, Date att_sdate, Date att_fdate, int study_time, String situ,
			String ip, double latitude, double longitude) {
		super();
		this.att_num = att_num;
		this.mem_num = mem_num;
		this.day = day;
		this.att_sdate = att_sdate;
		this.att_fdate = att_fdate;
		this.study_time = study_time;
		this.situ = situ;
		this.ip = ip;
		this.latitude = latitude;
		this.longitude = longitude;
	}


	public int getAtt_num() {
		return att_num;
	}

	public void setAtt_num(int att_num) {
		this.att_num = att_num;
	}

	public int getMem_num() {
		return mem_num;
	}

	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}

	public String getDay() {
		return day;
	}

	public void setDay(String day) {
		this.day = day;
	}

	public Date getAtt_sdate() {
		return att_sdate;
	}

	public void setAtt_sdate(Date att_sdate) {
		this.att_sdate = att_sdate;
	}

	public Date getAtt_fdate() {
		return att_fdate;
	}

	public void setAtt_fdate(Date att_fdate) {
		this.att_fdate = att_fdate;
	}

	public int getStudy_time() {
		return study_time;
	}

	public void setStudy_time(int study_time) {
		this.study_time = study_time;
	}

	public String getSitu() {
		return situ;
	}

	public void setSitu(String situ) {
		this.situ = situ;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public double getLatitude() {
		return latitude;
	}

	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}

	public double getLongitude() {
		return longitude;
	}

	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}
	

}
