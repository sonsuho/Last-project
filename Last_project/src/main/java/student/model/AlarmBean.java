package student.model;

public class AlarmBean {
	
	private int pk_alarmno;
	private int fk_recipientno;
	private String url;
	private String url2;
	private String alarm_content;
	private String alarm_type;
	private int view_status;
	private String writedate;
	
	public int getPk_alarmno() {
		return pk_alarmno;
	}
	public void setPk_alarmno(int pk_alarmno) {
		this.pk_alarmno = pk_alarmno;
	}
	
	public int getFk_recipientno() {
		return fk_recipientno;
	}
	public void setFk_recipientno(int fk_recipientno) {
		this.fk_recipientno = fk_recipientno;
	}
	
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	public String getUrl2() {
		return url2;
	}
	public void setUrl2(String url2) {
		this.url2 = url2;
	}
	
	public String getAlarm_content() {
		return alarm_content;
	}
	public void setAlarm_content(String alarm_content) {
		this.alarm_content = alarm_content;
	}
	
	public String getAlarm_type() {
		return alarm_type;
	}
	public void setAlarm_type(String alarm_type) {
		this.alarm_type = alarm_type;
	}
	
	public int getView_status() {
		return view_status;
	}
	public void setView_status(int view_status) {
		this.view_status = view_status;
	}
	
	public String getWritedate() {
		return writedate;
	}
	public void setWritedate(String writedate) {
		this.writedate = writedate;
	}
}
