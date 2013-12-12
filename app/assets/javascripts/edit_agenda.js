$(function() {
  $("form.edit_agenda").on('submit', function(){
    $.ajax({
      data: $(this).serialize(),
      url: $(this).attr('action'),
      type: $(this).attr('method'),
      dataType: 'json'
    }).success(function(json) {
        if(json.errors == true){
          var errors_html = "<ul>";
          json.messages.forEach(function(msg) {
            errors_html = errors_html + "<li>" + msg + "</li>";
          });
          errors_html += "</ul>";

          //alert('Preencha os campos obrigatórios');
          $("div#agenda-errors").html(errors_html);
          $("div#errors-window").modal();
        } else {
          window.location.replace(json.url);
        }
        
    });
    return false;
  });

});