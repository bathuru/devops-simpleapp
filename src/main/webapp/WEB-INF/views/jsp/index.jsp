<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Maven + Spring MVC</title>

<spring:url value="/resources/core/css/hello.css" var="coreCss" />
<spring:url value="/resources/core/css/bootstrap.min.css" var="bootstrapCss" />
<spring:url value="/resources/core/images" var="images" />

<link href="${bootstrapCss}" rel="stylesheet" />
<link href="${coreCss}" rel="stylesheet" />
<script type="text/javascript" src="/resources/core/js/hello.js"></script>
<script type="text/javascript">
function display_c(){
var refresh=1000; // Refresh rate in milli seconds
mytime=setTimeout('display_ct()',refresh)
}
function display_ct() {
	var x = new Date()
	var x1=x.toUTCString();// changing the display to UTC string
	document.getElementById('ct').innerHTML = x1;
	tt=display_c();
 }
</script>
</head>

<body onload=display_ct();>
<nav class="navbar navbar-inverse navbar-fixed-top">
	<div class="container">
		<div class="navbar-header">
			<a class="navbar-brand" href="#">Simple App</a>
		</div>
	</div>
</nav>

<div class="jumbotron">
	<div class="container">
		<h2>${title}</h2>      <h6 id='ct'  style="text-align:right"></h6>
	</br>
		<h4>
			<c:if test="${not empty msg}">
				 ${msg}
			</c:if>
     </br></br>
			<c:if test="${empty msg}">
				Welcome Welcome!
			</c:if>
		<h4>
			<a href="<c:url value='/hello/Srini' />" >Welcome</a>
		</p>
		<img src="${images}/devops.png" style="width:1000px;height:250px;/></br>
	</div>

</div>
<div class="container">
	<div class="row">
		<div class="col-md-8"> </br></br></br></br></br>
			<h4>Welcome To Mango Technologies, Hyderabad.</h4>
			<h5>Contact @ +91-8886399946</h5>
		</div>
	</div>

	<hr>
	<footer>
		<h5>&copy; Mango Technologies 2020</h5>
	</footer>
</div>

<spring:url value="/resources/core/css/hello.js" var="coreJs" />
<spring:url value="/resources/core/css/bootstrap.min.js" var="bootstrapJs" />

<script src="${coreJs}"></script>
<script src="${bootstrapJs}"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

</body>
</html>
