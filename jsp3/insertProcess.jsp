<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register process</title>
</head>
<body>

<%
//post parameter value 
request.setCharacterEncoding("utf-8");
//bring parameter value
String id=request.getParameter("id");
String passwd=request.getParameter("passwd");
String name=request.getParameter("name");
//present date
Timestamp regDate=new Timestamp(System.currentTimeMillis());

//DB접속정보
String url = "jdbc:oracle:thin:@localhost:1521:xe";
String user = "scott";
String password = "tiger";

//1단계: DB 드라이버 로딩
Class.forName("oracle.jdbc.OracleDriver");
//2단계: DB연결
Connection con = DriverManager.getConnection(url, user, password);
//3단계: sql문 준비해서 실행
//String sql = "INSERT INTO member (id, passwd, name) ";
//sql += "VALUES ('" + id + "', '" + passwd + "','" + name + "')";
String sql="";

sql = "INSERT INTO member (id, passwd, name, reg_date)";
sql += "VALUES(?,?,?,?)";

//sql = "INSERT INTO member (id, passwd, name)";
//sql += " VALUES (?,?,?)";
//커넥션(연결)객체 con으로부터 sql문 실행하는 문장객체 가져오기
//Statement stmt = con.createStatement();
PreparedStatement pstmt=con.prepareStatement(sql);
pstmt.setString(1,id);
pstmt.setString(2,passwd);
pstmt.setString(3,name);
pstmt.setTimestamp(4, regDate); // 네번째 물음표

//4단계: 실행 select문 //-> 결과 rs 저장
pstmt.executeUpdate();

%>

<h1>register process</h1>
registered<br>

<%
//JDBC object closed
//?stmt.close();
pstmt.close();
con.close();
%>

</body>
</html>