package configuration;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

public class Configuration {
	public static int recordCountPerPage = 10;
	public static int naviCountPerPage = 10;
	public static BasicDataSource dbs = new BasicDataSource();
	
	static {
		dbs.setDriverClassName("oracle.jdbc.driver.OracleDriver");
		dbs.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
		dbs.setUsername("project");
		dbs.setPassword("project");
		dbs.setInitialSize(30);
	}	
}
