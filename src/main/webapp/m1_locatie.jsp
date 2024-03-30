<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"
	import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<link rel="stylesheet" type="text/css" href="style.css">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Locations Table</title>
<link href="style.css" rel="stylesheet" type="text/css" media="screen" />
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
	<h1 align="center">Locations Table:</h1>
	<br />
	<p align="center">
		<a href="nou_locatie.jsp"><b>Add a new location.</b></a>
	</p>
	<%
      jb.connect();
      String city, adress, phone;
      String primaryKey = request.getParameter("primarykey");

      if (primaryKey == null || primaryKey.isEmpty()) {
          // Afisati mesajul de eroare daca nu a fost selectat niciun element pentru modificare
      %>
      <p align="center">You have not selected any items to edit.</p>
      <%
      } else {
      int aux = java.lang.Integer.parseInt(request.getParameter("primarykey"));
      ResultSet rs = jb.intoarceLinieDupaId("locations", "id_location", aux);
      rs.first();
      int id1 = rs.getInt("id_location");
      int id_location;
      city = rs.getString("city");
      adress = rs.getString("adress");
      phone = rs.getString("phone");
      ResultSet rs1 = jb.vedeTabela("locations");
      %>
	<form action="m2_locatie.jsp" method="post">
		<table>
			<tr>
				<td align="right">Location ID:</td>

				<td align="left"><SELECT NAME="id_location">
						<%
                     while (rs1.next()) {
                   	id_location = rs1.getInt("id_location");
                   	city = rs1.getString("city");
                   	adress = rs1.getString("adress");
                   	phone = rs1.getString("phone");
                     if (id_location != id1) {
                     %>
						<OPTION VALUE="<%= id_location%>"><%= id_location%>,
							<%= city%>,
							<%=
                		  adress%>,
							<%= phone%></OPTION>
						<%
                     } else {
                     %>
						<OPTION selected="yes" VALUE="<%= id_location%>"><%= id_location%>,
							<%= city%>,
							<%= adress%>,
							<%= phone%>>
						</OPTION>
						<%
                     }
                     }
                     %>
				</SELECT></td>
			</tr>
			<tr>
				<td align="right">City:</td>
				<td align="left"><input type="text" name="city"
					value="<%= city%>" /></td>
			</tr>
			<tr>
				<td align="right">Adress:</td>
				<td align="left"><input type="text" name="adress"
					value="<%= adress%>" /></td>
			</tr>
			<tr>
				<td align="right">Phone:</td>
				<td align="left"><input type="text" name="phone"
					value="<%= phone%>" /></td>
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