<%-- Home page --%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Gene Search</title>
<style>
.input_b {
	font-size: 16px;
	padding: 8px 10px;
	border-color: #bdc7d8;
	-webkit-border-radius: 10px;
	margin: 0;
}

.input_gene {
	width: 170px;
	text-transform: uppercase;
	font-weight: bold;
}

.hmenu {
	background: #4F81BD;
	width: 100%;
	text-align: center;
	font-size: 19px;
	font-family: calibri;
	border-top: 2px solid #4F81BD;
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

.colorButton {
	background-color: #4F81BD;
	color: white;
}
</style>
</head>
<body>

	<div class="hmenu">Gene Search</div>

	<br>
	<br>


	<div style="margin: 0 auto; width: 620px">

		<fieldset style="background-color: #f9f9f9">
			<legend>INPUT GENE</legend>
			<div style="padding-left: 200px; padding-right: 150px">
				<div style="margin: 5px 10px">
					<span style="color: red;">*</span><span
						style="font-weight: bold; font-size: 16px">Gene Symbol:</span>
				</div>
				<div>
					<%--text box for gene input--%>
					<input type="text" id="gen_sym" class="input_b input_gene"></input>
				</div>
				<div style="font-weight: bold; margin: 5px">Example:BRAF</div>
			</div>
		</fieldset>
		<br>
		<%-- submit button --%>
		<div style="padding-left: 275px;">
			<input id="subButton" type="button" value="Submit" />
		</div>
	</div>

	<%-- jquery  library --%>
	<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
	<script>
	<%-- click event for submit button --%>
     $("#subButton").click(function(){
    	 var value = $("#gen_sym").val();
    	 if(value.length >0){
    	 window.location="<c:url value='/pathway?geneName="+value+"'/>";
    	 }else{
    		 <%-- if no input give alert --%>
    		 alert("Enter the gene!!");
    	 }
     });
   </script>

</body>
</html>