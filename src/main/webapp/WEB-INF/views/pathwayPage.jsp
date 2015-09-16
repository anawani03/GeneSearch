<%-- Displays the pathway information for the user entered gene--%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Pathway Tab</title>
<style>
.hmenu {
	background: #4F81BD;
	width: 100%;
	text-align: center;
	font-size: 18px;
	font-family: calibri;
}

.hmenu ul li {
	margin: 5px;
	padding: 5px;
	display: inline;
}

.hmenu ul li a {
	color: #fff;
}

.hmenu ul a:hover,.hmenu ul a.active {
	color: black;
	background-color: #fff;
}

.noInfo {
	width: 300px;
	height: 100px;
	position: absolute;
	top: 0;
	bottom: 0;
	left: 0;
	right: 0;
	font-family: century gothic;
	color: #9F1919;
	margin: auto;
}

.i_tab {
	text-align: left;
	border: thick;
	border-collapse: collapse;
	margin-top: 15px;
	margin-left: auto;
	margin-right: auto;
}

.i_tab th,td {
	border: 1px solid gray;
}

.i_tab  th {
	border: 1px solid #fff;
}

.i_tab td,th {
	padding: 3px 5px;
}

.i_tab  th {
	background-color: #4F81BD;
	color: #fff;
}
</style>

</head>
<body>

	<%--add title--%>

	<c:set var="title" value="${title}${fn:toUpperCase(map.geneName)}" />

	<%-- home tab --%>

	<div class="hmenu" id="sub-header">
		<ul>
			<li><a href="<c:url value='/'/>">Home </a></li>
		</ul>
	</div>

	<%-- Check if pathway information exists --%>

	<c:if test="${map.info == 'no'}">
		<div class="noInfo">
			<h3>No Pathway information for gene : ${map.geneName}.</h3>
		</div>
	</c:if>

	<c:if test="${map.info != 'no'}">

		<%-- main content --%>

		<div id="main">
			<br>
			<br>
			<div
				style="font-family: century gothic; color: #9F1919; font-size: 15px; padding-left: 10px; text-align: center; text-decoration: underline;">
				Pathway : <span style="text-transform: uppercase;">${map.geneName}</span>
			</div>

			<br>
			<br>
			<%-- table data--%>
			<table border="3" width="90%" class="i_tab">

             <%-- table header --%> 
				<thead>
					<tr>
						<th style="text-align: center;"><input type="checkbox"
							style="width: 20px;" id="selectall">Select</th>
						<th style="text-align: center;">Pathway Name</th>
						<th style="text-align: center;">KEGG Id</th>
						<th style="text-align: center;">Pathway in Database</th>
						<c:if test="${map.pathwaySize != 'zero'}">
							<th style="text-align: center;"><input type="checkbox"
								style="width: 20px;" id="selectall2">Select</th>
						</c:if>
					</tr>
				</thead>

               <%-- table body --%>
				<tbody>

					<c:set var="temp" value="0" />

                    <%-- iterate through list --%>
					<c:forEach var="item" items="${map.finalList}">
                        
                        <%-- add checkbox --%> 
						<c:if test="${temp == 0}">
							<tr>
								<td style="width: 5px;"><input class="checkbox1"
									type="checkbox" value="${item}"></td>
								<c:set var="chexVal" value="${fn:substringAfter(item,':')}" />
								<td>${chexVal}</td>
						</c:if>
						<%-- add link to KEGG ID --%>
						<c:if test="${temp == 1}">
							<c:set var="string1"
								value="http://www.genome.jp/kegg-bin/show_pathway?scale=1.0&query=" />
							<c:set var="string2" value="&map=" />
							<c:set var="string3"
								value="&scale=&auto_image=&show_description=hide&multi_query" />
							<c:set var="string4"
								value="${string1}${map.geneName}${string2}${item}${string3}" />
							<td><a href="${string4}"
								style="color: blue; text-decoration: underline;" target="_blank">${item}</a></td>
						</c:if>
						<c:if test="${temp == 2}">
							<c:set var="chexVal" value="${fn:substringAfter(item,':')}" />
							<td>${chexVal}</td>
							<c:if test="${map.pathwaySize != 'zero'}">
								<c:choose>
									<c:when test="${item == ''}">
										<td></td>
									</c:when>
									<c:otherwise>
										<td style="width: 5px;"><input class="checkbox2"
											type="checkbox" value="${item}"></td>
									</c:otherwise>
								</c:choose>
							</c:if>
							<c:set var="temp" value="-1" />
							</tr>
						</c:if>
						<c:set var="temp" value="${temp+1}" />
					</c:forEach>
				</tbody>
			</table>

		</div>
	</c:if>

</body>
</html>