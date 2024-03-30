<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"
	import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<link rel="stylesheet" type="text/css" href="style.css">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add Pharmacy</title>
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
	<%
	String pharmacy_name, pharmacy_website;
	pharmacy_name = request.getParameter("pharmacy_name");
	pharmacy_website = request.getParameter("pharmacy_website");
	if (pharmacy_name != null) {
		jb.connect();
		jb.adaugaFarmacie(pharmacy_name, pharmacy_website);
		jb.disconnect();
	%>
	<p align="center"><p1>The data has been added successfully.</p1></p>
	<%
	} else {
	jb.connect();
	ResultSet rs1 = jb.vedeTabela("locations");
	ResultSet rs2 = jb.vedeTabela("employees");
	%>
	<h1>Pharmacies Table.</h1>
	<form action="nou_farmacie.jsp" method="post">
		<table>
			<tr>
				<td align="right">Name:</td>
				<td align="left"><input type="text" name="pharmacy_name" /></td>
			</tr>
			<tr>
				<td align="right">Website:</td>
				<td align="left"><input type="text" name="pharmacy_website" /></td>
			</tr>
		</table>
		<p align="center">
		<button type="submit">Add a new pharmacy</button>
		</p>
	</form>
	<%
}
%>
	<br />
	<p align="center">
	<a href="index.html"><b>Home</b></a>
	</p>
	<br/>
	<script src="script.js"></script>   
</body>
</html>