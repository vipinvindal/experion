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

	<table>
	
		<tr class = "trHeader">
			<td>
			<table class = "headerTable">
			<tr >
			<td class="tdHeader">
			<img src="resources/experionLogo.png" class="experionLogo" /></td>
			<td align="right">
							<h3>Welcome</h3>
						</td>
			
			<td ><c:choose>
								<c:when test="${not empty fn:trim(sessionScope.user)}">

									<h3 align="center">${fn:trim(sessionScope.user)}</h3>

								</c:when>
								<c:otherwise>
									<h3 align="center">${fn:trim(userDetail.userId)}</h3>

								</c:otherwise>
							</c:choose></td>
						<td>
							<form action="userLogout.html" method="post">
								<input type="submit" value="Logout" />
							</form>
						</td>
		</tr>
		</table>
		</td>
		</tr>
		<!-- Start of body -->
		<tr class = "trBody" align = "center">
			<td>
				<table class="bodyHeader">
					<tr>

						
						<td>
							<form action="projectBack.html" method="post">
								<input type="submit" value="Go To Project" />
							</form>
						</td>
					</tr>
					</table>
					<tr>
						<td align = "center">
							<table class="bodyTableProjectWalkThrough" border="1">
					<tr>
							<td align="center" colspan="0" class="bodyTableTrHeader">Project Name</td>
							<td align="left" colspan="2"><input type="text" name="projectName"  value = "${projectDetail.name}" disabled ="true" />
							</td>
							
						</tr>
						
					    <c:forEach var="walkthrough" items="${walkthroughList}" >
						<tr>
						<td align="center" colspan="0" class="bodyTableTrHeader">WalkThrough Link</td>
						
						 <td align="left" colspan="0">
							
					    <input type="text" name="walkThroughLink"  value = "${walkthrough.urlLink}" disabled ="true" />
						<input type="hidden" name="walkThroughId" value = "${walkthrough.id}" /></td>
                        <td>
                        <s:form method="post"
						action="./walkThroughDelete.html?walkThroughId=${walkthrough.id}&projectId=${projectDetail.id}">
						<input type="submit" value="Delete Walkthrough" />
                        </s:form>
                        </td>
                        </tr>
                        </c:forEach>
					
						<s:form method="post"
						action="./walkThroughAdd.html?projectId=${projectDetail.id} "
						modelAttribute="walkthrough" enctype="multipart/form-data">
						 <tr>
											
						  <td align="center" colspan="3" class="bodyTableTrHeaderFirst">
							
					   Add New Walk Through
                        </td>
                        </tr>
                        <tr>
                        <td align="center" colspan="0" class="bodyTableTrHeader">Enter WalkThrough Link</td>
                        <td align="left" colspan="0"> <s:input type="text" path ="walkThroughLink"  />
                        </td>
                       	<td align="center" colspan="0"><input type="submit" value="Add Walkthrough" /></td>
						</tr>



					</s:form>

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