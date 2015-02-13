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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="resources/style1.css" rel="stylesheet" type="text/css"	media="all" />

</head>

<body>
	<table>
		<tr class = "trHeader"><td>
			<table class = "headerTable">
				<tr><td class="tdHeader">
					<img src="resources/experionLogo.png" class="experionLogo" />
				</td><td align="right">
					<h3>Welcome</h3>
				</td>
				<td>
					<c:choose>
						<c:when test="${not empty fn:trim(sessionScope.user)}">
							<h3 align="center">${fn:trim(sessionScope.user)}</h3>
						</c:when>
						<c:otherwise>
							<h3 align="center">${fn:trim(userDetail.userId)}</h3>
						</c:otherwise>
					</c:choose>
				</td>
				<td>
					<form action="userLogout.html" method="post">
						<input type="submit" value="Logout" />
					</form>
				</td></tr>
			</table>
		</td></tr>
		<!-- Start of body -->
		<tr class = "trBody" align = "center" valign="top"><td>
			<table class="bodyHeader">
				<tr>
					<s:form method="post" action="./projectAdd.html?" modelAttribute="projectAdd" enctype="multipart/form-data">
						<td align="center" colspan="0"><input type="submit" value="Add Project" /></td>
					</s:form>
					<s:form method="post" action="./feed.html?" modelAttribute="uploadFeed" enctype="multipart/form-data">
						<td align="center" colspan="0"><input type="submit" value="Add/Edit Feed" /></td>
					</s:form>
					<s:form method="post" action="./configList.html" >
						<td align="center" colspan="0"><input type="submit" value="Configuration" /></td>
					</s:form>
				</tr>
			</table>
		</td></tr>
		<!-- Start of project detail of body -->
		<tr>
			<td align = "center">
				<table class="bodyTable" border="1" >
					<c:if test="${not empty projectList}">
						<tr class = "bodyTableTrHeader">
							<td>Project Name</td>
							<td>Gallery</td>
							<td>Feature</td>
							<td>Walk Through</td>
							<td>Location Map</td>
							<td>Edit Project</td>
							<td>Delete Project</td>
						</tr >
						
						<c:forEach var="projectDetail" items="${projectList}">
						<tr class="bodyTableTrNonHeader" >
							<td colspan="0" class = "bodyTableTdHeader">${projectDetail.name}</td>
							<td colspan="0" class = "bodyTableTdNonHeader">
								<s:form method="post" action="./gallery.html?projectId=${projectDetail.id}">
									<input type="submit" value="Add/Edit Gallery" />
								</s:form>
							</td>
							<td colspan="0" class = "bodyTableTdNonHeader">
								<s:form method="post" action="./feature.html?projectId=${projectDetail.id}">
									<input type="submit" value="Add/Edit Feature" />
								</s:form>
							</td>
							<td colspan="0" class = "bodyTableTdNonHeader">
								<s:form method="post" action="./walkthrough.html?projectId=${projectDetail.id}">
									<input type="submit" value="Add/Edit Walkthrough" />
								</s:form>
							</td>
							<td colspan="0" class = "bodyTableTdNonHeader">
								<s:form method="post" action="./locationMap.html?projectId=${projectDetail.id}">
									<input type="submit" value="Add/Edit Location Map" />
								</s:form>
							</td>
							<td colspan="0" class = "bodyTableTdNonHeader">
								<s:form method="post" action="./projectEdit.html?projectId=${projectDetail.id}">
									<input type="submit" value="EDIT" />
								</s:form>
							</td>
							<td colspan="0" class = "bodyTableTdNonHeader">
								<s:form method="post" action="./projectDelete.html?projectId=${projectDetail.id}">
									<input type="submit" value="Delete" />
								</s:form>
							</td>
						</tr>
						</c:forEach>
					</c:if>
				</table>
			</td>
		</tr>
		<!-- end of body -->

		<tr class = "trFooter">
			<td >
				<img src="resources/belogo.png"  class = "beLogo" align = "right"/>
				<h4 >Powered  by Beyond Evolution Tech Solutions</h4>
			</td>
		</tr>
	</table>
</body>

</html>