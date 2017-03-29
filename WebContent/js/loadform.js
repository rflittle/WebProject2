
function onSelectReportType(ele){
	var form = $(ele).parent().parent();
	var label = $(form).find(".additional_msg");
	var select = $(form).find(".additional_msg_select");

	switch (ele.value) {
	case "donation":
	case "request" :
		label.text("Resource Type:");
		select.find('option').remove();
		select.append($("<option></option>")
				.attr("value","")
				.text("Choose the resource type"));
		selectValues = ['water', 'food', 'money', 'medicine', 'cloth',
			'rescue/volunteer'];
		$.each(selectValues, function(index,value) {
			select.append($("<option></option>")
					.attr("value", value)
					.text(value));
		});
		break;
	case "damage":
		label.text("Damage Type:");
		select.find('option').remove();
		select.append($("<option></option>")
				.attr("value", "")
				.text("Choose the damage type"));
		selectValues = ['pollution', 'building damage', 'road damage', 'casualty',
			'other'];
		$.each(selectValues, function(index, value) {
			select.append($("<option></option>")
					.attr("value", value)
					.text(value));
		});
		break;
	default:
		$(form).find(".additional_msg_div").css("visibility", "hidden");
	return;
	}
	$(form).find(".additional_msg_div").css("visibility", "visible")
}

function queryReport(event) {
	event.preventDefault(); // stop form from submitting normally

	var a = $("#query_report_form").serializeArray();
	a.push({ name: "tab_id", value: "1" });
	a = a.filter(function(item){return item.value != '';});
	$.ajax({
		url: 'HttpServlet',
		type: 'POST',
		data: a,
		success: function(reports) {
			
			// call function to display updated map
			mapInitialization(reports);
		},
		error: function(xhr, status, error) {
			alert("Status: " + status + "\nError: " + error);
		}
	});
} 

$("#query_report_form").on("submit", queryReport);
$("#create_report_form").on("submit", createReport);

function createReport(event){
	event.preventDefault(); // stop form from submitting normally

	var a = $("#create_report_form").serializeArray();
	a.push({ name: "tab_id", value: "0"});
	a.push({name: "longitude", value: place.geometry.location.lng()})
	a.push({name: "latitude", value: place.geometry.location.lat()})
	a = a.filter(function(item){return item.value != '';});
	$.ajax({
		url: 'HttpServlet',
		type: 'POST',
		data: a,
		success: function(reports) {

			// alert success
			alert("The report is successfully submitted!");
			
			$.ajax({
				url: 'HttpServlet',
				type: 'POST',
				data: { "tab_id": "1"},
				success: function(reports) { 
					
					// call function to display map, then center on new report with tag
					mapInitialization(reports);
					onPlaceChanged();
				},
				error: function(xhr, status, error) {
					alert("An AJAX error occured: " + status + "\nError: " + error);
				}
			});
			
			// reset form and use jQuery to set visibility of addt'l message to hidden
			$("#create_report_form")[0].reset();
			$("#create_report_form").find(".additional_msg_div").css("visibility", "hidden");
			
		},
		error: function(xhr, status, error) {
			alert("Status: " + status + "\nError: " + error);
		}
	});

	
}