package modoo.funding.back.vo;

public class LoginInfo {

	private String id;
	private String pw;
	private String name;
	private String saveId;
	
	public String getSaveId() {
		return saveId;
	}

	public void setSaveId(String saveId) {
		this.saveId = saveId;
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
}
