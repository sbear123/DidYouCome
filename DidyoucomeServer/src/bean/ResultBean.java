package bean;

import java.util.List;

public class ResultBean {
	public String result;
	private String time;
	private String type;
	private String name;
	private int check;
	
	private List<CheckBean> user;

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	public ResultBean() {
		this.result = "fail";
	}
	
	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}
	
	public List<CheckBean> getUser() {
		return user;
	}

	public void setUser(List<CheckBean> user) {
		this.user = user;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getCheck() {
		return check;
	}

	public void setCheck(int check) {
		this.check = check;
	}
}
