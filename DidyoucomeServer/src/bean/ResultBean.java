package bean;

public class ResultBean {
	public String result;
	private String type;
	
	public ResultBean() {
		this.result = "fail";
	}
	
	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
}
