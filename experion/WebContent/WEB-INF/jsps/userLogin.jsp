<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<html>
<head>
<title>Experion</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="resources/style1.css" rel="stylesheet" type="text/css"	media="all" />
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
							<c:if test="${not empty fn:trim(userDetail)}">
								<h3 class="labels" align="center">${fn:trim(userDetail)}</h3>
								
							</c:if>
							<h2 class="contentcaption">Login</h2> 
						 <c:if test="${sessionScope.errorMessage != null}">
								<p class="contentcaption">${sessionScope.errorMessage}</p>
							</c:if>

							<form action="userLoginSuccess.html" method="post">

								<table class="formTable">
									<tr>
										<td>User Id:</td>
										<td><input type="text" name="userId" id="userId" /></td>
									</tr>

									<tr>
										<td>Password</td>
										<td><input type="password" name="password" id="password" /></td>
									</tr>

									<tr >
										<td colspan="2" align= "right"><input type="reset" value="Reset" /><input type="submit" value="Login" /></td>
									</tr>
								</table>

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
				<h2 >&copy; 2013 Beyond Evolution Tech Solutions</h2>
			</td>
		</tr>
	</table>
</body>
</html>