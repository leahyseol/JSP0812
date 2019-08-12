<%@page import="java.sql.Timestamp"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		//DB driver loading
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "scott";
		String PW = "tiger";
		//1ST : DB driver loading
		Class.forName("oracle.jdbc.OracleDriver");
		//2ND: DB connection
		Connection con = DriverManager.getConnection(url, user, PW);
		//3RD: SQL state 
		String sql = "SELECT * FROM member ORDER BY id";

		//Statement stmt = con.createStatement();
		PreparedStatement pstmt = con.prepareStatement(sql);
		//4TH: select statemets execute
		ResultSet rs = pstmt.executeQuery();
	%>
	<h1>member list</h1>
	<table border="1">
		<tr>
			<th>ID</th>
			<th>PW</th>
			<th>name</th>
			<th>register date</th>
		</tr>
		<%
			//5th: rs save result -> output
			while (rs.next()) { // move cursor to next row(data exist -> true/data non-exist -> false)
				String id = rs.getString("ID");
				String passwd = rs.getString("PASSWD");
				String name = rs.getString("NAME");
				Timestamp regDate = rs.getTimestamp("reg_date");
		%>
		<tr>
			<td><%=id%></td>
			<td><%=passwd%></td>
			<td><%=name%></td>
			<td><%=regDate %></td>
		</tr>
		<%
			}
		%>
		</table>
		
		<%
		rs.close();
		pstmt.close();
		con.close();
		
		%>

</body>
</html>