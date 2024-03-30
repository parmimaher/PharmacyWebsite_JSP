<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"
	import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<link rel="stylesheet" type="text/css" href="style.css">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add Employee</title>
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
	</header>
	<%
	String employee_name = request.getParameter("employee_name");
	String employee_surname = request.getParameter("employee_surname");
	String employee_position = request.getParameter("employee_position");
	String salary_parameter = request.getParameter("salary");
	String id_pharmacy_parameter = request.getParameter("id_pharmacy");

	int id_pharmacy = 0;
	if (id_pharmacy_parameter != null) {
		id_pharmacy = Integer.valueOf(id_pharmacy_parameter);
	}

	int salary = 0;
	if (salary_parameter != null) {
		salary = Integer.valueOf(salary_parameter);
	}

	if (employee_name != null) {
		jb.connect();
		jb.adaugaAngajat(id_pharmacy, employee_name, employee_surname, employee_position, salary);
		jb.disconnect();
	%>
	<p align="center">
		<p1>The data has been added successfully.</p1>
	</p>
	<%
	} else {
	%>
	<h1>Employees Table.</h1>
	<form action="nou_angajat.jsp" method="post">
		<table>
			<tr>
				<td align="right">Pharmacy ID:</td>
				<td align="left"><input type="text" name="id_pharmacy" /></td>
			</tr>
			<tr>
				<td align="right">Name:</td>
				<td align="left"><input type="text" name="employee_name" /></td>
			</tr>
			<tr>
				<td align="right">Surname:</td>
				<td align="left"><input type="text" name="employee_surname" /></td>
			</tr>
			<tr>
				<td align="right">Position:</td>
				<td align="left"><input type="text" name="employee_position" /></td>
			</tr>
			<tr>
				<td align="right">Salary:</td>
				<td align="left"><input type="text" name="salary"></td>
			</tr>
		</table>
		<p align="center">
			<button type="submit">Add a new employee</button>
		</p>
	</form>
	<%
	}
	%>
	<br />
	<p align="center">
		<a href="index.html"><b>Home</b></a>
	</p>
	<br />
	<script src="script.js"></script>
</body>
</html>