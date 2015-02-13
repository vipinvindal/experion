<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<html>
<head>
<title>Experion</title>
<link rel="shortcut icon" href="resources/bets.ico" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="resources/style1.css" rel="stylesheet" type="text/css"	media="all" />

<script type="text/javascript">
	function fileTypeValidate() {
		var type = "csv"
		var fileName = document.getElementById("id_appConfigFile").value;
		if (fileName != "" && fileName != null) {
			var fileExtention = fileName.substring(fileName.lastIndexOf('.') + 1).toLowerCase();			
			if (fileExtention != type) {
				alert('Incorrected Format File,File type should be .CSV');
				document.getElementById("id_appConfigFile").focus();
				return false;
			}
		} else {
			alert('Please Select the File');
			document.getElementById("id_appConfigFile").focus();
			return false;
		}

	}
</script>
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
		<tr><td>
			<div class="content">
				<c:if test="${sessionScope.errorMessage != null}">
					<p class="contentcaption">${sessionScope.errorMessage}</p>
				</c:if>
				<c:if test="${sessionScope.successMessage != null}">
					<p class="contentcaption">${sessionScope.successMessage}</p>
				</c:if>
			</div>
		</td></tr>
		<tr class = "trBody" align = "center" valign="top"><td>
			<table class="bodyHeader">
				<tr>
					<form action="projectBack.html" method="post">
						<input type="submit" value="Go To Project" />
					</form>
				</tr>
			</table>
		</td></tr>
		<!-- Start of project detail of body -->
		<tr>
			<td align="center">
				<table>
					<tr align = "center">
						<td>
							<button type="button" onclick="window.location='${pageContext.request.contextPath}/exportAppConfigFile.html'">
								Export</button>
						</td>
						<td>
							<form  action="./importAppConfigFile.html" method="post" enctype="multipart/form-data" onsubmit="return fileTypeValidate()">
								<button type="submit">Upload</button>
								<input type="file" name="appConfigFile" id="id_appConfigFile" size="250" />
							</form>
						</td>
					</tr >
				</table>
			</td>
		</tr>
		<tr>
			<td align = "center">
				<table class="bodyTable" border="1" >
					<c:if test="${not empty listAppConfig}">
						<tr class = "bodyTableTrHeader">
							<td>Key</td>
							<td>Default Value</td>
							<td>Custom Value</td>
							<td>Save</td>
						</tr >
						
						<c:forEach var="appConfig" items="${listAppConfig}">
						<tr>
							<form method="post" action="saveAppConfig.html" />
								<td width=220px><input type="hidden" name="id" id="id" value="${appConfig.id}">
									<p class="contentbody">${appConfig.configKey}</p>
								</td>
								<td width=440px>
									<p class="contentbody">${appConfig.defaultValue}</p>
								</td>
								<td width=440px>
									<input type="text" name="customValue" id="customValue" size="100" value="${appConfig.customValue}">
								</td>
								<td><input type="submit" value="Save"></td>
							</form>
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