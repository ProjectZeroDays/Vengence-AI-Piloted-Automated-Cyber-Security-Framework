$(document).ready(function() {
    $('#scan-form').on('submit', function(e) {
        e.preventDefault();
        var tool = $('#tool').val();
        var target = $('#target').val();
        $.ajax({
            url: '/api/start_scan',
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({ tool: tool, target: target }),
            success: function(response) {
                $('#scan-results').html('<pre>' + JSON.stringify(response, null, 2) + '</pre>');
            }
        });
    });

    $('#forms-form').on('submit', function(e) {
        e.preventDefault();
        var company_name = $('#company_name').val();
        $.ajax({
            url: '/api/generate_forms',
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({ client_info: { company_name: company_name } }),
            success: function(response) {
                $('#forms-results').html('<pre>' + JSON.stringify(response, null, 2) + '</pre>');
            }
        });
    });
});
