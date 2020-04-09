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
</head>

<nav class="navbar navbar-inverse navbar-fixed-top">
	<div class="container">
		<div class="navbar-header">
			<a class="navbar-brand" href="#">Simple App</a>
		</div>
	</div>
</nav>

<div class="jumbotron">
	<div class="container">
		<h2>${title}</h2></br>
		<h4>
			<c:if test="${not empty msg}">
				 ${msg}
			</c:if>
     </br></br></br></br>
			<c:if test="${empty msg}">
				Welcome Welcome!
			</c:if>
		<h4>
			<a href="<c:url value='/hello/Srini' />" >Welcome</a>
		</p>
	</div>

	  <img src="${images}/devops.png"/>
     </br></br></br></br></br></br></br></br></br></br></br></br></br></br>
</div>

<div class="container">
	<div class="row">
		<div class="col-md-8">
			<h4>Welcome To Mango Technologies, Hyderabad.</h4>
			<h5>Contact @ +91-8886399946</h5>
		</div>
	</div>

	<hr>
	<footer>
		<p>&copy; Mango Technologies 2020</p>
	</footer>
</div>

<spring:url value="/resources/core/css/hello.js" var="coreJs" />
<spring:url value="/resources/core/css/bootstrap.min.js" var="bootstrapJs" />

<script src="${coreJs}"></script>
<script src="${bootstrapJs}"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

</body>
</html>
