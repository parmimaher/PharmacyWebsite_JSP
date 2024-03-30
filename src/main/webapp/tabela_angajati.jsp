<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"
	import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<link rel="stylesheet" type="text/css" href="style.css">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Employees table</title>
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
	<h1 align="center">Employees table:</h1>
	<br />
	<p align="center">
		<a href="nou_angajat.jsp"> <b>Add a new employee</b></a>
	</p>
	<form action="sterge_angajat.jsp" method="post">
		<table>
			<tr>
				<td><b> Mark:</b></td>
				<td><b> Pharmacy ID:</b></td>
				<td><b> Employee ID:</b></td>
				<td><b> Name:</b></td>
				<td><b> Surname:</b></td>
				<td><b> Position:</b></td>
				<td><b> Salary:</b></td>
				<td><b> Pharmacy name:</b></td>
				<td><b> Pharmacy website:</b></td>
			</tr>
			<%
            jb.connect(); 
			ResultSet rs=jb.vedeEmployee(); 
            long x; 
            while (rs.next()) { x=rs.getInt( "id_employee"); 
            %>
			<tr>
				<td><input type="checkbox" name="primarykey" value="<%= x%>" />
				</td>
				<td><%=rs.getString( "id_pharmacy")%></td>
				<td><%=x %></td>
				<td><%=rs.getString( "employee_name")%></td>
				<td><%=rs.getString( "employee_surname")%></td>
				<td><%=rs.getString( "employee_position")%></td>
				<td><%=rs.getString( "salary")%></td>
				<td><%=rs.getString( "pharmacy_name")%></td>
				<td><%=rs.getString( "pharmacy_website")%></td>
				<% } %>
			</tr>
		</table>
		<br />
		<p align="center">
			<button type="submit">Delete marked lines</button>
		</p>
	</form>
	<% rs.close(); jb.disconnect(); %>
	<br />
	<p align="center">
		<a href="index.html"> <b> Home </b>
		</a> <br />
	</p>
	<script src="script.js"></script>
</body>
</html>