package bean;

public class UserBean {
	
	private String userid;
	private String password;
	private String name;
	private String school;
	private int schoolnum;
	private int typeid;
	private String type;
	private int checkId;
	private String check;
	private String time;

	public int getCheck() {
		return checkId;
	}

	public void setCheck(int check) {
		this.checkId = check;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserId(String userid) {
		this.userid = userid;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSchool() {
		return school;
	}

	public void setSchool(String shool) {
		this.school = shool;
	}

	public int getSchoolnum() {
		return schoolnum;
	}

	public void setSchoolnum(int shoolnum) {
		this.schoolnum = shoolnum;
	}

	public int getTypeId() {
		return typeid;
	}

	public void setTypeId(int typeid) {
		this.typeid = typeid;
	}

	public String getCheckType() {
		return check;
	}

	public void setCheckType(String checkType) {
		this.check = checkType;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	public String getType() {
		return type;
	}
	
}
