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
<link href="resources/style1.css" rel="stylesheet" type="text/css"
	media="all" />
<script type="text/javascript">
function validateForm() {
   
    var form = document.getElementById("uploadFeed");
     
      for (var i = 0; i < form.elements.length; i++) {
    	   if (form.elements[i].id == "files") {
               if(form.elements[i].value == null || form.elements[i].value == "")
            	   {
            	   alert("Please select files for:  " +form.elements[i-1].value);
            	   return false;
            	   }
          }
    	  if (form.elements[i].id == "feedTitle") {
              if(form.elements[i].value == null || form.elements[i].value == "")
           	   {
           	   alert("Please enter feed title");
           	   return false;
           	   }
         }
    	  if (form.elements[i].id == "description") {
              if(form.elements[i].value == null || form.elements[i].value == "")
           	   {
           	   alert("Please enter description");
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
		<tr class="trBody" align="center">
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
					<s:form method="post" action="./feedAdd.html"
						modelAttribute="uploadFeed" enctype="multipart/form-data" onsubmit= "return validateForm();">

						<tr>
						<td align = "center">
							<table class="bodyTableProject" border="1">
						<tr>
							<td align="center" colspan="0" class="bodyTableTrHeader">Feed Title</td>
							<td align="left" colspan="0"><s:input type="text" path="feedTitle"  /></td>
							
						</tr>
						<tr>
						<td align="center" colspan="0" class="bodyTableTrHeader"> Feed Description</td>
						
							<td align="left" colspan="0">
							
						<s:textarea cols="40" rows="2" maxlength="300" class="textArea" path="description" />
                        
                        
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
							<td align="center" colspan="2"><input type="submit" value="Add Feed" /></td>
						</tr>

				</table>
			</td>
		</tr>
	</s:form> 
				<tr>
			<td align = "center" style="padding-top: 10px">
				<table class="bodyTable" border="1" >
					<c:if test="${not empty feedList}">
						<tr class = "bodyTableTrHeaderFirst">
							<td colspan="100%">Added Feed</td>
							
						</tr >
						<tr class = "bodyTableTrHeader">
							<td>Feed Title</td>
							<td>Description</td>
							<td>Delete Feed</td>
						</tr >

						<c:forEach var="feedDetail" items="${feedList}">


							<!-- <input id="addFile" type="button" value="Add File" /> -->


							<tr class="bodyTableTrNonHeader" >

								<td colspan="0" class = "bodyTableTdHeader">${feedDetail.title}</td>


								<td colspan="0" class = "bodyTableTdNonHeader">${feedDetail.description}</td>
								<td colspan="0" class = "bodyTableTdNonHeader"><s:form method="post"
										action="./feedDelete.html?feedId=${feedDetail.id}">
										<input type="submit" value="Delete" />
									</s:form></td>
								
							</tr>

						</c:forEach>

					</c:if>

				</table>

			</td>
		</tr>
				
				
				
				
				
				
				<!-- end of body -->
		<tr class="trFooter">
			<td><img src="resources/belogo.png" class="beLogo" align="right" />
				<h4>Powered by Beyond Evolution Tech Solutions</h4></td>
		</tr>
	</table>
</body>

</html>