package member.model;

public class MemberBean {
	
	private int mem_num;
	private String name;
	private String id;
	private String pw;
	private String category;
	private String lec_num;
	private String addr;
	private String phone;
	private String email;
	private String state;	
	private int vacationNum;
	private String mem_ip;
	private double mem_latitude;
	public double getMem_latitude() {
		return mem_latitude;
	}
	public void setMem_latitude(double mem_latitude) {
		this.mem_latitude = mem_latitude;
	}
	public double getMem_longitude() {
		return mem_longitude;
	}
	public void setMem_longitude(double mem_longitude) {
		this.mem_longitude = mem_longitude;
	}
	private double mem_longitude;
	
	public String getMem_ip() {
		return mem_ip;
	}
	public void setMem_ip(String mem_ip) {
		this.mem_ip = mem_ip;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	
	public String getLec_num() {
		return lec_num;
	}
	public void setLec_num(String lec_num) {
		this.lec_num = lec_num;
	}
	
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	
	public int getVacationNum() {
		return vacationNum;
	}
	public void setVacationNum(int vacationNum) {
		this.vacationNum = vacationNum;
	}
	
}
