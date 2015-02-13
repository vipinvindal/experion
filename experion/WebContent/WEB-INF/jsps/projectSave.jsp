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
<script type="text/javascript">
function validateForm() {
   
    var form = document.getElementById("uploadProject");
     
      for (var i = 0; i < form.elements.length; i++) {
    	   if (form.elements[i].id == "files") {
               if(form.elements[i].value == null || form.elements[i].value == "")
            	   {
            	   alert("Please select files for:  " +form.elements[i-1].value);
            	   return false;
            	   }
          }
    	  if (form.elements[i].id == "projectName") {
              if(form.elements[i].value == null || form.elements[i].value == "")
           	   {
           	   alert("Please enter project name");
           	   return false;
           	   }
         }
    	  if (form.elements[i].id == "shortDescription") {
              if(form.elements[i].value == null || form.elements[i].value == "")
           	   {
           	   alert("Please enter short description");
           	   return false;
           	   }
         }
    	  if (form.elements[i].id == "longDescription") {
              if(form.elements[i].value == null || form.elements[i].value == "")
           	   {
           	   alert("Please enter long description");
           	   return false;
           	   }
         }
      }
    return true;
}	

</script>
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

					<s:form method="post"
						action="./projectSave.html"
						modelAttribute="uploadProject" enctype="multipart/form-data" onsubmit= "return validateForm();">

						<tr>
						<td align = "center">
							<table class="bodyTableProject" border="1">
						<tr>
							<td align="center" colspan="0" class="bodyTableTrHeader">Project Name</td>
							<td align="left" colspan="0"><s:input type="text" path="projectName"  /></td>
							
						</tr>
						<tr>
						<td align="center" colspan="0" class="bodyTableTrHeader"> Project Short Description</td>
						
							<td align="center" colspan="0">
							
						<s:textarea cols="40" rows="2" maxlength="300" class="textArea" path="shortDescription" value = "${projectDetail.shortDescription}"/>
                        
                        
                        </td>
                        </tr>
                        <tr>
						<td align="center" colspan="0" class="bodyTableTrHeader">Project Long Description</td>
						
							<td align="center" colspan="0">
							
						<s:textarea cols="40" rows="5" maxlength="2000" class="textArea" path="longDescription" value = "${projectDetail.longDescription}"/>
                        
                        
                        </td>
                        </tr>
                       </table>
                       </td>
                       </tr>
                       <tr>
                       <td align = "center">
                       <table class="bodyTable" border="1" > 
                        
                        <tr class="bodyTableTrHeaderFirst">
							<td colspan="2">Select Logo to upload</td>
						
							
						</tr>
						
						 <c:forEach var="imageType" items="${sessionScope.imageTypeList}" >
						<tr class = "bodyTableTdNonHeader">
							
						    <td colspan="0">
						    <h4> ${imageType.displayName}</h4>
						     <s:input type="hidden" path="iamgeTypeName" value = "${imageType.displayName}" />
						    </td>
							<td colspan="0"> <s:input path="files" type="file" />
							<s:input type="hidden" path="iamgeTypeId" value = "${imageType.id}" />
							<s:input type="hidden" path="iamgeTypeResolution" value = "${imageType.resolution}" /></td>
						</tr>
                        
                        </c:forEach>
                        
                        
						<tr>
							<td align="center" colspan="2"><input type="submit" value="Add Project" /></td>
						</tr>



				
				</table>
			</td>
		</tr>
	</s:form>

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