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
	private double mem_longitude;
	private String image;
	private String gender;
	private String birth;
	
	public MemberBean() {
		
	}

	public MemberBean(int mem_num, int lec_num2, String name, String id, String pw, String category, String lec_num,
			String addr, String phone, String email, String state, int vacationNum, String mem_ip, double mem_latitude,
			double mem_longitude) {
		super();
		this.mem_num = mem_num;
		this.name = name;
		this.id = id;
		this.pw = pw;
		this.category = category;
		this.lec_num = lec_num;
		this.addr = addr;
		this.phone = phone;
		this.email = email;
		this.state = state;
		this.vacationNum = vacationNum;
		this.mem_ip = mem_ip;
		this.mem_latitude = mem_latitude;
		this.mem_longitude = mem_longitude;
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

	public String getMem_ip() {
		return mem_ip;
	}

	public void setMem_ip(String mem_ip) {
		this.mem_ip = mem_ip;
	}

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

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}
	
}