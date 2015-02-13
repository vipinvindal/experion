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
				</table> <s:form method="post"
					action="./addGallery.html?projectId=${projectDetail.id}"
					modelAttribute="gallery" enctype="multipart/form-data">

					<tr>
						<td align="center">
							<table class="bodyTableProject" border="1">
								<tr>
									<td align="center" colspan="0" class="bodyTableTrHeader">Project
										Name</td>
									<td align="left" colspan="0"><s:input type="text"
											path="projectName" value="${projectDetail.name}"
											disabled="true" /></td>

								</tr>
								<tr>
									<td colspan="2" class="bodyTableTrHeaderFirst">Select
										Gallery Image to upload</td>


								</tr>
								<c:forEach var="imageType" items="${sessionScope.imageTypeList}">

									<tr class="bodyTableTrNonHeader">

										<td colspan="0">${imageType.displayName}</td>
										<td colspan="0"><s:input path="files" type="file" /> <s:input
												type="hidden" path="iamgeTypeId" value="${imageType.id}" />
											<s:input type="hidden" path="iamgeTypeResolution"
												value="${imageType.resolution}" /></td>
									</tr>

								</c:forEach>


								<tr>
									<td align="center" colspan="2"><input type="submit"
										value="Add Gallery" /></td>
								</tr>

							</table>

						</td>
					</tr>
				</s:form> <c:if test="${not empty dataList}">
					<%-- 	<c:set var="galleryMapKey" value="${galleryDetailMap.keySet()}" scope="page"/> --%>
					<c:set var="imageTypeList" value="${sessionScope.imageTypeList}"
						scope="page" />
					<tr>
						<td align="center">
							<table class="bodyTable" border="1">
								<tr class="bodyTableTrHeaderFirst">

									<td colspan="100%">Uploaded Gallery Images</td>



								</tr>

								<tr class="bodyTableTrHeader">
									<c:forEach var="imageType" items="${imageTypeList}">
										<td colspan="0">${imageType.displayName}</td>
									</c:forEach>
									<td>Delete</td>

								</tr>


								<c:forEach varStatus="galleryMapCount" items="${dataList}">
									<c:set var="galleryMapInfoList"
										value="${dataList[galleryMapCount.index]}" scope="page" />
									<c:set var="commonName"
										value="${commanNameList[galleryMapCount.index]}" scope="page" />

									<tr class="bodyTableTrNonHeader">
										<c:forEach varStatus="loopCount" items="${galleryMapInfoList}">
											<c:set var="galleryInfo"
												value="${galleryMapInfoList[loopCount.index]}" scope="page" />
											<c:set var="imageTypeId"
												value="${imageTypeList[loopCount.index]}" scope="page" />


											<c:choose>

												<c:when test="${not empty galleryInfo}">
													<td><img
														src="<c:url value='/viewImage.html?imagePath=${galleryInfo.imagePath}'/>"
														border="1" width="80" height="80"> <s:form
															method="post"
															action="./deleteSinglegallery.html?galleryId=${galleryInfo.id}&projectId=${projectDetail.id}">
															<input type="submit" value="Delete Image" />
														</s:form></td>
												</c:when>
												<c:otherwise>
													<td><s:form method="post"
															action="./updateGallery.html?galleryCommon=${commonName}&projectId=${projectDetail.id}"
															modelAttribute="gallery" enctype="multipart/form-data">
															<s:input path="files" type="file" size="100" />
															<s:input type="hidden" path="iamgeTypeId"
																value="${(imageTypeId.id)}" />
															<s:input type="hidden" path="iamgeTypeResolution"
																value="${imageTypeId.resolution}" />
															<input type="submit" value="Add Image" />
														</s:form></td>
												</c:otherwise>
											</c:choose>

										</c:forEach>

										<td><s:form method="post"
												action="./deleteGallery.html?galleryCommon=${commonName}&projectId=${projectDetail.id}">
												<input type="submit" value="Delete Images" />
											</s:form></td>

									</tr>



								</c:forEach>



							</table>
						</td>
					</tr>
				</c:if> <!-- end of body -->
		<tr class="trFooter">
			<td><img src="resources/belogo.png" class="beLogo"
				align="right" />
				<h4>Powered by Beyond Evolution Tech Solutions</h4></td>
		</tr>
	</table>
</body>

</html>