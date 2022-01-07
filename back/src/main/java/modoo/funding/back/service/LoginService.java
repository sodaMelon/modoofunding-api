package modoo.funding.back.service;
import modoo.funding.back.dao.UserDao;
import modoo.funding.back.exception.IdPasswordNotMatchingException;
import modoo.funding.back.vo.LoginSubmit;
import modoo.funding.back.vo.User;

public class LoginService {
	private UserDao userDao;
	
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
	
	public LoginSubmit adminLogin(String id, String pw) throws Exception {
		User user = userDao.adminSelectById(id);
		if(user == null) {
			System.out.println("usernull");
		}
		if(!user.matchPassword(pw)) {
			throw new IdPasswordNotMatchingException();
		}
		return new LoginSubmit(user.getId(), user.getPwd());
	}
	
	public LoginSubmit userLogin(String id, String pw) throws Exception {
		pw = encSHA256(pw);
		
		User user = userDao.userSelectById(id);
//여기에 탈퇴 exception 추가 
		if(user == null || !user.matchPassword(pw)) {
			throw new IdPasswordNotMatchingException();
		}
		return new LoginSubmit(user.getId(), user.getPwd(),user.getName());
	}
	
	public LoginSubmit LoginReload(String id) throws Exception {
		User user = userDao.userSelectById(id);

		return new LoginSubmit(user.getId(), user.getPwd(),user.getName());
	}
	
    public String encSHA256 (String password) throws Exception {
		/*
		 * MessageDigest md = MessageDigest.getInstance("SHA-256"); byte[] mdResult =
		 * md.digest(password.getBytes());
		 * 
		 * //sun.misc.BASE64Encoder encoder = new sun.misc.BASE64Encoder();
		 * 
		 * String str = mdResult;//encoder.encode(mdResult);
		 */
  	  return password;  
    }
    

}