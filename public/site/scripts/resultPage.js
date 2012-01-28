window.application = {};



function renderTemplate() {

	// Json values
	var data = { "teachers": [
		{"name": "Rafael", "lastName": "Chiti", "telefono": "TRUE", "domicilio": "TRUE" }, 
		{"name": "Pedro", "lastName": "Castro", "telefono": "FALSE", "domicilio": "TRUE" }, 
		{"name": "Diego", "lastName": "Espada", "telefono": "TRUE", "domicilio": "FALSE" }
		]};

	// Caching the template to be used later
	$("#resultTemplate").template("resultTemplate");
	$("#resultsColumn").append($.tmpl("resultTemplate", data));
	
}

