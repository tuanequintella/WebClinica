window.appointmentsBehavior = function (){

  $("#appointment_record_id").on('change', function() {
    if($(this).val() == "") {
      $("#appointment_record_pacient_name").val("");
      $("#appointment_record_pacient_phone").val("");
      $("#appointment_record_status").val("new");
      //resetar health_insurances
      $("#last_appointment_date").hide();
    }else {
      $.ajax({
        url: "/records/" + $(this).val(),
        dataType: 'json'
      }).success(function(record) {
        
        $("#appointment_record_pacient_name").val(record.pacient.name);
        $("#appointment_record_pacient_phone").val(record.pacient.phone);
        $("#appointment_record_status").val(record.status);
        //filtrar health_insurances

        if(record.last_appointment != null) {
          $("#record_last_appointment_date").val(record.last_appointment.localized_date);
          $("#last_appointment_date").show();
          
          dateArr = $("#appointment_scheduled_at").val().split(" ");
          dateArr = dateArr[0].split("/");
          appDate = new Date(dateArr[2],(dateArr[1]-1),dateArr[0]);
          appDate.setHours(0,0,0,0);
          validDate = new Date(record.next_valid_appointment_date);
          validDate.setHours(0,0,0,0);
          if(appDate < validDate) {
            formatedDate = validDate.getDate() + "/" + (validDate.getMonth()+1);
            $("#appointment-date-warning").html("<center>" +
              "A última consulta ocorreu em menos de 30 dias.<br />" +
              "Para evitar retorno marque a partir de " + formatedDate +
              "</center>");
            $("#appointment-date-warning").show();
          } else {
            $("#appointment-date-warning").hide();
          }
        } else {
          $("#last_appointment_date").hide();
        }
        
      });
    } 
  });

  $("#appointment-window").on('hidden', function() {
    $("#appointment_record_id").val("");
    $("#appointment_record_id").trigger("change");
  });

  var setDate = function (date) {
    $("#appointment_scheduled_at").val(date);
  };

  $("a.free-spot-link").on('click', function (e) {
    setDate( $(e.currentTarget).parent().data("date") );
    $("#appointment-window").modal();
  });

  $("a.busy-spot-link").on('click', function (e) {
    setDate( $(e.currentTarget).parent().data("date") );
    $("#appointment_record_id").val( $(e.currentTarget).parent().data("record") );
    $("#appointment_record_id").trigger("change");
    $("#appointment-window").modal(); 
  });

}