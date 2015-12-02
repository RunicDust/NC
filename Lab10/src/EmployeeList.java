import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class EmployeeList {

	public static void main(String[] args) throws SQLException, ClassNotFoundException {
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		
		Class. forName("oracle.jdbc.driver.OracleDriver");
		  conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "skazzi","2202"); 
		  
		// Create an SQL query
		  String sqlQuery = "SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE LAST_NAME='King'";
		  
		  // Create an instance of statement odject
		  stmt = conn.createStatement();
		  
		  // Execute
		  
		  rs = stmt.executeQuery(sqlQuery);
		  //Process result
		  
		  while (rs.next()){
			  int empNo = rs.getInt("EMPLOYEE_ID");
			  System.out.println(empNo);
		  }
		  
		  
		  rs.close();
		  stmt.close();
		  conn.close();
	}

}
