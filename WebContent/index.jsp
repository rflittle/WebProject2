<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Web Project</title>
<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
</head>
<body>
	<script>
	window.onload = tests();
	function tests() {
		test_report_submission();
		test_query_report();
	}
	
	function test_report_submission() {
		$.ajax({
		    url: 'HttpServlet',
		    type: 'POST',
		    data: { "tab_id": "0", "fN": "Dannis", "lN": "Black",   
		    	"report_type": "damage", "disaster_type": "hurricane", "longitude": 
		    	"-26.89", "latitude": "35.12", "additional_message": "pollution"},
		    success: function(data){ 
		    	$.each(data, function(i, name) {
		    		alert("key: " + i + ", value: " + name);
		    	});
		    },
		    error: function(xhr, status, error) {
			    alert("An AJAX error occured: " + status + "\nError: " + error);
			  }
		});
	}
	
	function test_query_report() {
		$.ajax({
		    url: 'HttpServlet',
		    type: 'POST',
		    data: { "tab_id": "1", "disaster_type": "hurricane", "report_type": 
		    	"donation"},
		    success: function(data){ 
		    	$.each(data, function(i, e) {
		    		alert(JSON.stringify(e));
		    	});
		    },
		    error: function(xhr, status, error) {
			    alert("An AJAX error occured: " + status + "\nError: " + error);
			  }
		});
	}
	</script>
</body>
</html>