package modoo.funding.back.config;

import modoo.funding.back.dao.*;
import modoo.funding.back.service.*;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import javax.sql.DataSource;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.SQLFeatureNotSupportedException;
import java.util.logging.Logger;

@Configuration
public class ServiceConfig {
	public DataSource dataSource(){
		return new DataSource() {
			@Override
			public PrintWriter getLogWriter() throws SQLException {
				return null;
			}

			@Override
			public void setLogWriter(PrintWriter out) throws SQLException {

			}

			@Override
			public void setLoginTimeout(int seconds) throws SQLException {

			}

			@Override
			public int getLoginTimeout() throws SQLException {
				return 0;
			}

			@Override
			public Logger getParentLogger() throws SQLFeatureNotSupportedException {
				return null;
			}

			@Override
			public <T> T unwrap(Class<T> iface) throws SQLException {
				return null;
			}

			@Override
			public boolean isWrapperFor(Class<?> iface) throws SQLException {
				return false;
			}

			@Override
			public Connection getConnection() throws SQLException {
				return null;
			}

			@Override
			public Connection getConnection(String username, String password) throws SQLException {
				return null;
			}
		};//temp method
	}

/*	@Bean //db설정
	public DataSource dataSource() {
		ComboPooledDataSource ds = new ComboPooledDataSource();
		try {
			ds.setDriverClass("com.mysql.jdbc.Driver");
		} catch (PropertyVetoException e) {
			throw new RuntimeException(e);
		}

		ds.setJdbcUrl("jdbc:mysql://192.168.0.21:3306/team2");
		ds.setUser("team2");
		ds.setPassword("team2");

		return ds;
	}*/

	@Bean
	public UserDao userDao() {
		return new UserDao(dataSource());
	}

	@Bean
	public ProjectDao projectDao() {
		return new ProjectDao(dataSource());
	}

	@Bean
	public NewPjService newPjService() {
		NewPjService newPjSvc = new NewPjService();
		newPjSvc.setNewPjService(projectDao());
		return newPjSvc;
	}

	@Bean
	public LoginService loginService() {
		LoginService loginSvc = new LoginService();
		loginSvc.setUserDao(userDao());
		return loginSvc;
	}

	@Bean(name = "multipartResolver")
	public CommonsMultipartResolver multipartResolver() {
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
		multipartResolver.setMaxUploadSize(100000000);
		return multipartResolver;
	}

	////////////////////////////////////////////////////
	@Bean
	public BoardDao boradDao() {
		return new BoardDao(dataSource());
	}

	@Bean
	U_bWriteSvc ubWriteSvc() {
		return new U_bWriteSvc(boradDao(), commentDao());
	}

	@Bean
	public CommentDao commentDao() {
		return new CommentDao(dataSource());
	}

	@Bean
	public UserRegisterService userRegSvc() {
		return new UserRegisterService(userDao());
	}

	@Bean
	UserProjectService userProjectService() {
		return new UserProjectService(projectDao(), userDao());
	}

	@Bean
	public FundingDao fundingDao() {
		return new FundingDao(dataSource());
	}

	@Bean
	UserFundingService userFundingService() {
		return new UserFundingService(fundingDao());
	}

	////////////////////////////////////////////////////
	@Bean
	public AdProjectDao adProjectDao() {
		return new AdProjectDao(dataSource());
	}

}
