/*
 * Curs5_Eclipse - Valentin Pupezescu
 */
package db;

import java.sql.*;

/**
 *
 * @author vali
 */
public class JavaBean {

	String error;
	Connection con;

	public JavaBean() {
	}

	public void connect() throws ClassNotFoundException, SQLException, Exception {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			// con = DriverManager.getConnection("jdbc:mysql://localhost:3306/spital?user=root&password=ValentinPupezescu2021;");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharma_industry?useSSL=false", "root", "20Ani2002!");
			// daca sunt probleme la conectare se poate incerca conexiunea in forma urmatoare:
            // con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test3?useSSL=false?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "ValentinPupezescu2021;");
		} catch (ClassNotFoundException cnfe) {
			error = "ClassNotFoundException: Nu s-a gasit driverul bazei de date.";
			throw new ClassNotFoundException(error);
		} catch (SQLException cnfe) {
			error = "SQLException: Nu se poate conecta la baza de date.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "Exception: A aparut o exceptie neprevazuta in timp ce se stabilea legatura la baza de date.";
			throw new Exception(error);
		}
	} // connect()

	public void connect(String bd) throws ClassNotFoundException, SQLException, Exception {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + bd, "root", "20Ani2002!;");
		} catch (ClassNotFoundException cnfe) {
			error = "ClassNotFoundException: Nu s-a gasit driverul bazei de date.";
			throw new ClassNotFoundException(error);
		} catch (SQLException cnfe) {
			error = "SQLException: Nu se poate conecta la baza de date.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "Exception: A aparut o exceptie neprevazuta in timp ce se stabilea legatura la baza de date.";
			throw new Exception(error);
		}
	} // connect(String bd)

	public void connect(String bd, String ip) throws ClassNotFoundException, SQLException, Exception {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://" + ip + ":3306/" + bd, "root", "20Ani2002!;");
		} catch (ClassNotFoundException cnfe) {
			error = "ClassNotFoundException: Nu s-a gasit driverul bazei de date.";
			throw new ClassNotFoundException(error);
		} catch (SQLException cnfe) {
			error = "SQLException: Nu se poate conecta la baza de date.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "Exception: A aparut o exceptie neprevazuta in timp ce se stabilea legatura la baza de date.";
			throw new Exception(error);
		}
	} // connect(String bd, String ip)

	public void disconnect() throws SQLException {
		try {
			if (con != null) {
				con.close();
			}
		} catch (SQLException sqle) {
			error = ("SQLException: Nu se poate inchide conexiunea la baza de date.");
			throw new SQLException(error);
		}
	} // disconnect()

	public void adaugaLocatie(int id_pharmacy, String city, String adress, String phone)
			throws SQLException, Exception {
		if (con != null) {
			try {
				// create a prepared SQL statement
				Statement stmt;
				stmt = con.createStatement();
				stmt.executeUpdate("insert into locations(id_pharmacy ,city, adress, phone) values('" + id_pharmacy + "'  , '" + city + 
						"'  , '" + adress + "', '" + phone + "');");

			} catch (SQLException sqle) {
				error = "ExceptieSQL: Reactualizare nereusita; este posibil sa existe duplicate.";
				throw new SQLException(error);
			}
		} else {
			error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
			throw new Exception(error);
		}
	} // end of adaugaLocatie()

	public void adaugaAngajat(int id_pharmacy, String employee_name, String employee_surname, String employee_position, int salary)
			throws SQLException, Exception {
		if (con != null) {
			try {
				// create a prepared SQL statement
				Statement stmt;
				stmt = con.createStatement();
				stmt.executeUpdate("insert into employees(id_pharmacy, employee_name, employee_surname, employee_position, salary) values"
						+ "('" + id_pharmacy + "'  , '" + employee_name + "'  , '" + employee_surname + "', '" + employee_position + "', '"  + salary + "');");

			} catch (SQLException sqle) {
				error = "ExceptieSQL: Reactualizare nereusita; este posibil sa existe duplicate.";
				throw new SQLException(error);
			}
		} else {
			error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
			throw new Exception(error);
		}
	} // end of adaugaAngajat()

	public void adaugaFarmacie(String pharmacy_name, String pharmacy_website)
			throws SQLException, Exception {
		if (con != null) {
			try {
				// create a prepared SQL statement
				Statement stmt;
				stmt = con.createStatement();
				stmt.executeUpdate("insert into pharmacies(pharmacy_name, pharmacy_website) values('" + pharmacy_name + "', '" + pharmacy_website + "');");
				// se poate modifica valoarea datei astfel incat sa se ia data curenta a sistemului:
				// stmt.executeUpdate("insert into consultatie(idpacient, idmedic, DataConsultatie, Diagnostic, Medicament) values('" + idpacient + "'  , '" + idmedic + "', CURDATE(), '" + Diagnostic + "', '" + Medicament + "');");

			} catch (SQLException sqle) {
				error = "ExceptieSQL: Reactualizare nereusita; este posibil sa existe duplicate.";
				throw new SQLException(error);
			}
		} else {
			error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
			throw new Exception(error);
		}
	} // end of adaugaFarmacie()

	public ResultSet vedeTabela(String tabel) throws SQLException, Exception {
		ResultSet rs = null;
		try {
			String queryString = ("select * from `pharma_industry`.`" + tabel + "`;");
			Statement stmt = con.createStatement(/*ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY*/);
			rs = stmt.executeQuery(queryString);
		} catch (SQLException sqle) {
			error = "SQLException: Interogarea nu a fost posibila.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "A aparut o exceptie in timp ce se extrageau datele.";
			throw new Exception(error);
		}
		return rs;
	} // vedeTabela()

	public ResultSet vedeFarmacie() throws SQLException, Exception {
		ResultSet rs = null;
		try {
			String queryString = ("select a.city, a.adress, a.phone, b.employee_name, b.employee_surname, b.employee_position, b.salary, c.id_pharmacy, c.pharmacy_name, c.pharmacy_website from locations a, employees b, pharmacies c where c.id_pharmacy = a.id_pharmacy and c.id_pharmacy = b.id_pharmacy;");
			Statement stmt = con.createStatement(/*ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY*/);
			rs = stmt.executeQuery(queryString);
		} catch (SQLException sqle) {
			error = "SQLException: Interogarea nu a fost posibila.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "A aparut o exceptie in timp ce se extrageau datele.";
			throw new Exception(error);
		}
		return rs;
	} // vedeConsultatie()
	
	public ResultSet vedeEmployee() throws SQLException, Exception {
		ResultSet rs = null;
		try {
			String queryString = ("select b.id_employee, b.employee_name, b.employee_surname, b.employee_position, b.salary, c.id_pharmacy, c.pharmacy_name, c.pharmacy_website from employees b , pharmacies c where c.id_pharmacy = b.id_pharmacy;");
			Statement stmt = con.createStatement(/*ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY*/);
			rs = stmt.executeQuery(queryString);
		} catch (SQLException sqle) {
			error = "SQLException: Interogarea nu a fost posibila.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "A aparut o exceptie in timp ce se extrageau datele.";
			throw new Exception(error);
		}
		return rs;
	}
	
	public ResultSet vedeLocation() throws SQLException, Exception {
		ResultSet rs = null;
		try {
			String queryString = ("select a.id_location, a.city, a.adress, a.phone, c.id_pharmacy, c.pharmacy_name, c.pharmacy_website from locations a , pharmacies c where c.id_pharmacy = a.id_pharmacy");
			Statement stmt = con.createStatement(/*ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY*/);
			rs = stmt.executeQuery(queryString);
		} catch (SQLException sqle) {
			error = "SQLException: Interogarea nu a fost posibila.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "A aparut o exceptie in timp ce se extrageau datele.";
			throw new Exception(error);
		}
		return rs;
	}
	
	public void stergeDateTabela(String[] primaryKeys, String tabela, String dupaID) throws SQLException, Exception {
	    if (con != null) {
	        try {
	            if (primaryKeys == null || primaryKeys.length == 0) {
	                System.out.println("Nu ați selectat niciun element pentru ștergere.");
	                return;
	            }

	            long aux;
	            PreparedStatement delete;
	            delete = con.prepareStatement("DELETE FROM " + tabela + " WHERE " + dupaID + "=?;");
	            for (int i = 0; i < primaryKeys.length; i++) {
	                aux = java.lang.Long.parseLong(primaryKeys[i]);
	                delete.setLong(1, aux);
	                delete.execute();
	            }
	        } catch (SQLException sqle) {
	            error = "ExceptieSQL: Reactualizare nereusita; este posibil sa existe duplicate.";
	            throw new SQLException(error);
	        } catch (Exception e) {
	            error = "A aparut o exceptie in timp ce erau sterse inregistrarile.";
	            throw new Exception(error);
	        }
	    } else {
	        error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
	        throw new Exception(error);
	    }
	}// end of stergeDateTabela()


	public void stergeTabela(String tabela) throws SQLException, Exception {
		if (con != null) {
			try {
				// create a prepared SQL statement
				Statement stmt;
				stmt = con.createStatement();
				stmt.executeUpdate("delete from " + tabela + ";");
			} catch (SQLException sqle) {
				error = "ExceptieSQL: Stergere nereusita; este posibil sa existe duplicate.";
				throw new SQLException(error);
			}
		} else {
			error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
			throw new Exception(error);
		}
	} // end of stergeTabela()

	public void modificaTabela(String tabela, String IDTabela, int ID, String[] campuri, String[] valori) throws SQLException, Exception {
	    String update = "update " + tabela + " set ";
	    String temp = "";
	    if (con != null) {
	        try {
	            if (campuri == null || valori == null || campuri.length == 0 || valori.length == 0 || campuri.length != valori.length) {
	                System.out.println("Nu ați selectat elementul pentru modificare sau nu ați furnizat câmpuri și valori valide.");
	                return;
	            }

	            for (int i = 0; i < campuri.length; i++) {
	                if (i != (campuri.length - 1)) {
	                    temp = temp + campuri[i] + "='" + valori[i] + "', ";
	                } else {
	                    temp = temp + campuri[i] + "='" + valori[i] + "' where " + IDTabela + " = '" + ID + "';";
	                }
	            }
	            update = update + temp;
	            // create a prepared SQL statement
	            Statement stmt;
	            stmt = con.createStatement();
	            stmt.executeUpdate(update);
	        } catch (SQLException sqle) {
	            error = "ExceptieSQL: Reactualizare nereusita; este posibil sa existe duplicate.";
	            throw new SQLException(error);
	        }
	    } else {
	        error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
	        throw new Exception(error);
	    }
	} // end of modificaTabela()

	public ResultSet intoarceLinie(String tabela, int ID) throws SQLException, Exception {
		ResultSet rs = null;
		try {
			// Execute query
			String queryString = ("SELECT * FROM " + tabela + " where idpacient=" + ID + ";");
			Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(queryString); //sql exception
		} catch (SQLException sqle) {
			error = "SQLException: Interogarea nu a fost posibila.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "A aparut o exceptie in timp ce se extrageau datele.";
			throw new Exception(error);
		}
		return rs;
	} // end of intoarceLinie()

	public ResultSet intoarceLinieDupaId(String tabela, String denumireId, int ID) throws SQLException, Exception {
		ResultSet rs = null;
		try {
			// Execute query
			String queryString = ("SELECT * FROM " + tabela + " where " + denumireId + "=" + ID + ";");
			Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(queryString); //sql exception
		} catch (SQLException sqle) {
			error = "SQLException: Interogarea nu a fost posibila.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "A aparut o exceptie in timp ce se extrageau datele.";
			throw new Exception(error);
		}
		return rs;
	} // end of intoarceLinieDupaId()

	public ResultSet intoarceFarmacieId(int ID) throws SQLException, Exception {
		ResultSet rs = null;
		try {
			// Execute query
			String queryString = ("SELECT a.city, a.adress, a.phone, b.id_employee, b.employee_name, b.employee_surname, b.employee_position, b.salary, c.id_pharmacy, c.pharmacy_name, c.pharmacy_website from locations a, employees b, pharmacies c where a.id_pharmacy=c.id_pharmacy and b.id_pharmacy=c.id_pharmacy and c.id_pharmacy ="
					+ ID + ";");
			Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(queryString); //sql exception
		} catch (SQLException sqle) {
			error = "SQLException: Interogarea nu a fost posibila.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "A aparut o exceptie in timp ce se extrageau datele.";
			throw new Exception(error);
		}
		return rs;
	} // end of intoarceLinieDupaId()
}