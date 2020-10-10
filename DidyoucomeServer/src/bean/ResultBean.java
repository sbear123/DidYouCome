package bean;

public class ResultBean {
	public String result;
	private String name;
	private String type;
	private String shool;
	
	public ResultBean() {
		this.result = "fail";
	}
	
	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getShool() {
		return shool;
	}

	public void setShool(String shool) {
		this.shool = shool;
	}
}
