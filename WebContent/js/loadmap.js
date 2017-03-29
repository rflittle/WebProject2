
var map;
var place;
var autocomplete;
var infowindow = new google.maps.InfoWindow();

function initialization() {
	showAllReports();
	initAutocomplete();
}

function showAllReports() {
	$.ajax({
		url: 'HttpServlet',
		type: 'POST',
		data: { "tab_id": "1"},
		success: function(reports) { 
			mapInitialization(reports);
		},
		error: function(xhr, status, error) {
			alert("An AJAX error occured: " + status + "\nError: " + error);
		}
	});
}

function mapInitialization(reports) {
	var mapOptions = {
			mapTypeId : google.maps.MapTypeId.ROADMAP, // Set the type of Map
	};

	// Render the map within the empty div
	map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

	var bounds = new google.maps.LatLngBounds ();

	$.each(reports, function(i, e) {
		var long = Number(e['longitude']);
		var lat = Number(e['latitude']);
		var latlng = new google.maps.LatLng(lat, long); 

		bounds.extend(latlng);

		// Create the infoWindow content
		var contentStr = '<h4>Report Details</h4><hr>';
		contentStr += '<p><b>' + 'Reporter' + ':</b>&nbsp' + e['first_name'] + '&nbsp' +
    		e['last_name'] + '</p>';
		contentStr += '<p><b>' + 'Disaster' + ':</b>&nbsp' + e['disaster'] + '</p>';
		contentStr += '<p><b>' + 'Report Type' + ':</b>&nbsp' + e['report_type'] + 
		'</p>';
		if (e['report_type'] == 'request' || e['report_type'] == 'donation') {
			contentStr += '<p><b>' + 'Resource Type' + ':</b>&nbsp' + 
			e['resource_type'] + '</p>';
		}
		else if (e['report_type'] == 'damage') {
			contentStr += '<p><b>' + 'Damage Type' + ':</b>&nbsp' + e['damage_type'] 
			+ '</p>';
		}
		contentStr += '<p><b>' + 'Timestamp' + ':</b>&nbsp' + 
		e['time_stamp'].substring(0,19) + '</p>';
		if ('message' in e){
			contentStr += '<p><b>' + 'Message' + ':</b>&nbsp' + e['message'] + '</p>';
		}

		// set icon images
		if (e['report_type'] == 'request'){
			image = "http://maps.google.com/mapfiles/kml/pal3/icon59.png"
		}
		else if (e['report_type'] == 'donation'){
			image = "http://maps.google.com/mapfiles/kml/pal2/icon58.png"
		}
		else if (e['report_type'] == 'damage'){
			image = "http://maps.google.com/mapfiles/kml/pal3/icon46.png"
		}

		// Create the marker
		var marker = new google.maps.Marker({ // Set the marker
			position : latlng, // Position marker to coordinates
			map : map, // assign the market to our map variable
			icon: image,
			customInfo: contentStr,
		});

		// Add a Click Listener to the marker
		google.maps.event.addListener(marker, 'click', function() { 
			// use 'customInfo' to customize infoWindow
			infowindow.setContent(marker['customInfo']);
			infowindow.open(map, marker); // Open InfoWindow
		});

	});

	map.fitBounds (bounds);

}

function initAutocomplete() {
	// Create the autocomplete object
	autocomplete = new google.maps.places.Autocomplete(document
			.getElementById('autocomplete'));

	// When the user selects an address from the dropdown, show the place selected
	autocomplete.addListener('place_changed', onPlaceChanged);
}

function onPlaceChanged() {
	place = autocomplete.getPlace();

//	If the place has a geometry, then present it on a map.
	if (place.geometry.viewport) {
		map.fitBounds(place.geometry.viewport);
	} else {
		map.setCenter(place.geometry.location);
		map.setZoom(25);  // Why 17? Because it looks good.
	}

}

//Execute our 'initialization' function once the page has loaded.
google.maps.event.addDomListener(window, 'load', initialization);
