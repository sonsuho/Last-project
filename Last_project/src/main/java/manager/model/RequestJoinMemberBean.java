package manager.model;

public class RequestJoinMemberBean {
	private int req_num;
    private int mem_num;
    private int app_num;
    private String title;
    private String category;
    private String time1;
    private String time2;
    private String reason;
    private String ap_situ;
    private String sign;
    private String ap_delete;
    private String memberName;
    
    
    
	public int getApp_num() {
		return app_num;
	}
	public void setApp_num(int app_num) {
		this.app_num = app_num;
	}
	public String getAp_delete() {
		return ap_delete;
	}
	public void setAp_delete(String ap_delete) {
		this.ap_delete = ap_delete;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAp_situ() {
		return ap_situ;
	}
	public void setAp_situ(String ap_situ) {
		this.ap_situ = ap_situ;
	}
	public int getReq_num() {
		return req_num;
	}
	public void setReq_num(int req_num) {
		this.req_num = req_num;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getTime1() {
		return time1;
	}
	public void setTime1(String time1) {
		this.time1 = time1;
	}
	public String getTime2() {
		return time2;
	}
	public void setTime2(String time2) {
		this.time2 = time2;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getSign() {
		return sign;
	}
	public void setSign(String sign) {
		this.sign = sign;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
    
    
}
