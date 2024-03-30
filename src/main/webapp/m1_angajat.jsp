<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"
	import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<link rel="stylesheet" type="text/css" href="style.css">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Employees Table</title>
<link href="table.css" rel="stylesheet" type="text/css" media="screen" />
</head>
<jsp:useBean id="jb" scope="session" class="db.JavaBean" />
<jsp:setProperty name="jb" property="*" />
<body>
	<header>
	<h1>Pharma Industry database project</h1>
	<nav class="navbar">
	<ul class="nav-menu">
		<li class="nav-item"><a href="tabela_locatii.jsp"
			class="nav-link">Locations</a></li>
		<li class="nav-item"><a href="tabela_angajati.jsp"
			class="nav-link">Employees</a></li>
		<li class="nav-item"><a href="tabela_farmacii.jsp"
			class="nav-link">Pharmacies</a></li>
		<li class="subnav"><a href="#" class="nav-item">Modify </a>
			<div class="subnav-content">
				<c>
				<a href="modifica_locatie.jsp" class="nav-link">Modify Location</a></c>
				<c>
				<a href="modifica_angajat.jsp" class="nav-link">Modify Employee</a></c>
				<c>
				<a href="modifica_farmacie.jsp" class="nav-link">Modify Pharmacy</a></c>
			</div></li>
	</ul>
	<div class="hamburger">
		<span class="bar"></span> <span class="bar"></span> <span class="bar"></span>
	</div>
	</nav> </header>
	<h1 align="center">Employees Table:</h1>
	<br />
	<p align="center">
		<a href="nou_angajat.jsp"><b>Add a new employee.</b></a>
	</p>
	<%
      jb.connect();
      String employee_name, employee_surname, employee_position;
      String primaryKey = request.getParameter("primarykey");

      if (primaryKey == null || primaryKey.isEmpty()) {
          // Afisati mesajul de eroare daca nu a fost selectat niciun element pentru modificare
      %>
      <p align="center">You have not selected any items to edit.</p>
      <%
      } else {
      int salary;
      int aux = java.lang.Integer.parseInt(request.getParameter("primarykey"));
      ResultSet rs = jb.intoarceLinieDupaId("employees", "id_employee", aux);
      rs.first();
      int id1 = rs.getInt("id_employee");
      int id_employee;
      employee_name = rs.getString("employee_name");
      employee_surname = rs.getString("employee_surname");
      employee_position = rs.getString("employee_position");
      salary = rs.getInt("salary");
      ResultSet rs1 = jb.vedeTabela("employees");
      %>
	<form action="m2_angajat.jsp" method="post">
		<table>
			<tr>
				<td align="right">Employee ID:</td>
				<td align="left"><SELECT NAME="id_employee">
						<%
                     while (rs1.next()) {
                    id_employee = rs1.getInt("id_employee");
                    employee_name = rs1.getString("employee_name");
                    employee_surname = rs1.getString("employee_surname");
                    employee_position = rs1.getString("employee_position");
                    salary = rs1.getInt("salary");
                     if (id_employee != id1) {
                     %>
						<OPTION VALUE="<%= id_employee%>"><%= id_employee%>,
							<%= employee_name%>,
							<%=
                		  employee_surname%>,
							<%= employee_position%>,
							<%= salary%></OPTION>
						<%
                     } else {
                     %>
						<OPTION selected="yes" VALUE="<%= id_employee%>"><%= id_employee%>,
							<%= employee_name%>,
							<%= employee_surname%>,
							<%= employee_position%>,
							<%= salary%>>
						</OPTION>
						<%
                     }
                     }
                     %>
				</SELECT></td>
			</tr>
			<tr>
				<td align="right">Name:</td>
				<td align="left"><input type="text" name="employee_name"
					value="<%= employee_name%>" /></td>
			</tr>
			<tr>
				<td align="right">Surname:</td>
				<td align="left"><input type="text" name="employee_surname"
					value="<%= employee_surname%>" /></td>
			</tr>
			<tr>
				<td align="right">Position:</td>
				<td align="left"><input type="text" name="employee_position"
					value="<%= employee_position%>" /></td>
			</tr>
			<tr>
				<td align="right">Salary:</td>
				<td align="left"><input type="text" name="salary"
					value="<%= salary%>" /></td>
			</tr>
		</table>
		<p align="center">
			<button type="submit">Modify line</button>
		</p>
	</form>
	<p align="center">
		<a href="index.html"><b>Home</b></a> <br />
		<script src="script.js"></script>
</body>
<%
   rs.close();
   rs1.close();}
   jb.disconnect();
   %>
</html>