const API_URL_BASE = "http://localhost:3000/";

// Called whenever the API selection combo is changed
function api_select_on_change() {

    // Variables
    var api_select = document.getElementById("api_select");
    var api_url_text = document.getElementById("api_url_text");
    var parameters_textarea = document.getElementById("parameters_textarea");
    var result_textarea = document.getElementById("result_textarea");

    var api_id = api_select.options[api_select.selectedIndex].id;

    if (api_id == "9999") {
        api_url_text = API_URL_BASE;
        api_url_text.disabled = false;
    }
    else {
        api_url_text .value = API_URL_BASE + api_select.options[api_select.selectedIndex].text;
        api_url_text .disabled = true;
    }

    parameters_textarea.value = 'parameter1=value1&parameter2=value2';
    result_textarea.value = "";
}

function execute_ajax_search() {

    var api_select = document.getElementById("api_select");
    var parameters_textarea = document.getElementById("parameters_textarea");

    var api = api_select.value;
    api += "?format=json";

    var parameters = parameters_textarea.value;

    $.ajax({
        url:api,
        data:parameters,
        success:function (response) {
            $("#result_textarea").attr("value", JSON.stringify(response));
        },
        error:function (xhr, ajaxOptions, thrownError) {
            alert("There was an error with status: " + xhr.status + " => " + thrownError);
            $("#result_textarea").attr("value", xhr.responseText);
        }
    });
}