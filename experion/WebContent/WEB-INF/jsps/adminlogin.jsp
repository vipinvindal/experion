<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
	<title>ExperionAdminLogin</title>
	<link rel="shortcut icon" href="resources/bets.ico"/>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link href="resources/style1.css" rel="stylesheet" type="text/css" media="all" />
</head>
<body>

	<table>
		<tr class ="trHeaderNoLogin">
			<td ><img
				src="resources/experionLogo.png" class = "experionLogo" /></td>
		</tr>
		<!-- Start of body -->
		<tr align="center">
			<td>
				<table class="bodyTableLogin">
					<tr>
						<td>
							

							<form action="loginSuccess.html" method="post" align="center">
					User Id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:<input type="text" name="userId" id="userId"/><br/>
					Password&nbsp;&nbsp;:<input type="password" name="password" id="password"/><br/>
				<br/>
				<input type="reset" value="Reset"/>
				&nbsp;
				<input type="submit" value="Login"/>
			</form>

						</td>
					</tr>
				</table>
			</td>
		</tr>

		<!-- end of body -->

		<tr class = "trFooter">
			<td >
				<img src="resources/belogo.png"  class = "beLogo" align = "right"/>
				<h4>Powered by Beyond Evolution Tech Solutions</h4></td>
			</td>
		</tr>
	</table>
</body>

</html>