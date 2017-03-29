
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
  <title>Web Project</title>

  <!-- Custom styles -->
  <link rel="stylesheet" href="css/style.css">

  <!-- jQuery -->
  <script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
  <script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>

  <!-- Bootstrap -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

  <!-- Google Map js libraries -->
  <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&key=AIzaSyB3-SSRyISYS5v6Y-Z315I9LoaIJI1djs8&signed_in=true&libraries=places, visualization"></script>	
	
</head>

<body>
  <nav class="navbar navbar-inverse navbar-fixed-top">
    <a class="navbar-brand">Disaster Management Portal</a>
  </nav>
  
  <div class="container-fluid">
    <div class="row">
      <div class="sidebar col-xs-3">
       
        <!-- Tab Navs-->
        <ul class="nav nav-tabs">
          <li class="active"><a href="#create_report" data-toggle="tab">Create Report</a></li>
          <li><a href="#query_report" data-toggle="tab">Query</a></li>
        </ul>

        <!-- Tab panes -->
        <div class="tab-content ">
          <!-- Create Report Tab Panel -->
          <div class="tab-pane active" id="create_report">
            <form id = "create_report_form">
              <div><label>First Name:&nbsp</label><input placeholder="Your first name" name="fN"></div>
              <div><label>Last Name:&nbsp</label><input placeholder="Your last name" name="lN"></div>
              <div>
                <label><input type="radio" name="is_male" value="t">&nbspMale</label>
                <label><input type="radio" name="is_male" value="f">&nbspFemale</label>
              </div>
              <div><label>Age:&nbsp</label><input placeholder="Your age" name="age"></div>
              <div><label>Blood Type:</label>
                <select name="blood_type">
                  <option value="">Choose your blood type</option>
                  <option value="A">A</option>
                  <option value="B">B</option>
                  <option value="O">O</option>
                  <option value="AB">AB</option>
                  <option value="Other">Other</option>
                </select>
              </div>
              <div><label>Tel:&nbsp</label><input placeholder="Your telephone number" name="tel"></div>
              <div><label>Email:&nbsp</label><input placeholder="Your email address" name="email"></div>
              <div><label>Emergency Contact's First Name:&nbsp</label><input placeholder="Contact's first name" name="contact_fN"></div>
              <div><label>Emergency Contact's Last Name:&nbsp</label><input placeholder="Contact's last name" name="contact_lN"></div>
              <div><label>Emergency Contact's Phone:&nbsp</label><input placeholder="Contact's telephone number" name="contact_tel"></div>
              <div><label>Emergency Contact's Email:&nbsp</label><input placeholder="Contact's email address" name="contact_email"></div>
              <div><label>Report Type:</label>
                <select onchange="onSelectReportType(this)" name="report_type">
                  <option value="">Choose the report type</option>
                  <option value="donation">Donation</option>
                  <option value="request">Request</option>
                  <option value="damage">Damage Report</option>
                </select>
              </div>
              <div class="additional_msg_div" style="visibility: hidden"><label class="additional_msg"></label>
                <select class="additional_msg_select" name="additional_message"></select>
              </div>
              <div><label>Disaster Type:</label>
                <select name="disaster_type">
                  <option value="">Choose the disaster type</option>
                  <option value="flood">flood</option>
                  <option value="wildfire">wildfire</option>
                  <option value="earthquake">earthquake</option>
                  <option value="tornado">tornado</option>
                  <option value="hurricane">hurricane</option>
                  <option value="other">other</option>
                </select>
              </div>
              <div><label>Address:</label>
                <input id="autocomplete" placeholder="Address" >
              </div>
              <div><label>Comment:&nbsp</label><input placeholder="Additional message" name="message"></div>
              <button type="submit" class="btn btn-default" id="report_submit_btn">
                <span class="glyphicon glyphicon-ok"></span> Submit
              </button>
            </form>
          </div>

          <!-- Query Report Tab Panel -->
          <div class="tab-pane" id="query_report">
            <form id = "query_report_form">
              <div><label>Report Type:</label>
                <select onchange="onSelectReportType(this)" name="report_type">
                  <option value="">Choose the report type</option>
                  <option value="donation">Donation</option>
                  <option value="request">Request</option>
                  <option value="damage">Damage Report</option>
                </select>
              </div>
              <div class="additional_msg_div" style="visibility: hidden"><label class="additional_msg"></label>
                <select class="additional_msg_select" name="resource_or_damage"></select>
              </div>
              <div><label>Disaster Type:</label>
                <select name="disaster_type">
                  <option value="">Choose the disaster type</option>
                  <option value="flood">flood</option>
                  <option value="wildfire">wildfire</option>
                  <option value="earthquake">earthquake</option>
                  <option value="tornado">tornado</option>
                  <option value="hurricane">hurricane</option>
                  <option value="other">other</option>
                </select>
              </div>              
              <button type="submit" class="btn btn-default">
                <span class="glyphicon glyphicon-star"></span> Submit the query
              </button>
            </form>
          </div>
        </div>
      </div>

      <div id="map-canvas" class="col-xs-9"></div>

    </div>
  </div>

  <script src="js/loadform.js"></script>
  <script src="js/loadmap.js"></script>

</body>
</html>
