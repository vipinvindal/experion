<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 5 Transitional//EN" "http://www.w3.org/TR/html5/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="s"%>
<html>
<head>
<title>Experion</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="resources/style1.css" rel="stylesheet" type="text/css"	media="all" />
</head>

<body>

	<table >
		<tr class ="trHeaderNoLogin">
			<td ><img
				src="resources/experionLogo.png" class = "experionLogo" /></td>
		</tr>
		<!-- Start of body -->
		<tr class = "trBodyErrorPage" align = "center">
			<td>
				<table width= "100px">

					<tr>

						<td align="center">
	oops something went wrong. Please login again.
	
	<form action="userLogin.html" method="post">

								<input type="submit" value="Click Here To Login" />
								</form></td>
									</tr>
								
							
	</table>
		</td>
		</tr>
		<!-- end of body -->

		<tr class = "trFooter">
			<td >
				<img src="resources/belogo.png"  class = "beLogo" align = "right"/>
				<h4>Powered by Beyond Evolution Tech Solutions</h4></td>
			
		</tr>
	</table>
</body>
