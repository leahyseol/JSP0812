<%@page import="java.sql.*"%>
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
		request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("id");
		String passwd = request.getParameter("passwd");
		String name = request.getParameter("name");

		//DB접속정보
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "scott";
		String password = "tiger";

		//1단계: DB 드라이버 로딩
		Class.forName("oracle.jdbc.OracleDriver");
		//2단계: DB연결
		Connection con = DriverManager.getConnection(url, user, password);
		//3단계: id에 해당하는 passwd 가져오기
		String sql = "SELECT passwd FROM member WHERE id=?";
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1, id);
		//4단계:select statment execute -> bring rs
		ResultSet rs = pstmt.executeQuery();
		//5th step:
		//rs data(row=data) id exist
		//compare password / same -> update execute : sucessed revise
		//				   / different -> wrong password 
		//rs data(row=data) id non exist
		if (rs.next()) {
			//id exist
			if (passwd.equals(rs.getString("passwd"))) {
				sql = "UPDATE member";
				sql += " SET ";
				sql += " WHERE id = ?";
				
				pstmt=con.prepareStatement(sql);//updated a new pstmp creating
				pstmt.setString(1, name);
				pstmt.setString(2, id);
				//updated statement execute
				pstmt.executeUpdate();
				%>회원이름 수정성공!!<br><%
			} else {
				%>패스워드가 다릅니다.<br><%
			}
		} else {
			%>해당 아이디가 없습니다.<br><%
		}


		// JDBC 자원닫기
		rs.close();
		pstmt.close();
		con.close();
		%>
</body>
</html>