<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  isELIgnored="false"
 %>
 <%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <style>
		#container {
			width: 100%;
			margin: 0px auto;
			text-align:center;
			border: 0px solid #bcbcbc;
		}
		
		/* 주석: 하유리 */
		#header {
			border: 0px solid #bcbcbc;
			font-family: Pretendard-Regular;
		}
		
		#content {
	        width: 100%;
	        float: left;
	        border: 0px solid #bcbcbc;
		}

		#footer {
	        clear: both;
	        border: 0px solid #bcbcbc;
	        background-color: #128853;
	        width: 100%;
		}
    </style>
    <title><tiles:insertAttribute name="title" /></title>
</head>

<body>
	<div id="container">
		<div id="header">
         	<tiles:insertAttribute name="header"/>
      	</div>
	       	<%-- <div id="sidebar-left">
          	<tiles:insertAttribute name="side"/> 
      	</div> --%>
      	<div id="content">
          	<tiles:insertAttribute name="body"/>
      	</div>
      	<div id="footer">
          	<tiles:insertAttribute name="footer"/>
      	</div>
    </div>
</body>
</html>