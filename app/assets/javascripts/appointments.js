window.appointmentsBehavior = function (){

  $("#appointment_record_id").on('change', function() {
    if($(this).val() == "") {
      $("#appointment_record_pacient_name").val("");
      $("#appointment_record_pacient_name").removeAttr('disabled');
      $("#appointment_record_pacient_phone").val("");
      $("#appointment_record_pacient_phone").removeAttr('disabled');
      $("#appointment_record_status").val("new");
      //resetar health_insurances
      $("#last_appointment_date").hide();
    }else {
      $.ajax({
        url: "/records/" + $(this).val(),
        dataType: 'json'
      }).success(function(record) {
        
        $("#appointment_record_pacient_name").val(record.pacient.name);
        $("#appointment_record_pacient_name").attr('disabled','disabled');
        $("#appointment_record_pacient_phone").val(record.pacient.phone);
        $("#appointment_record_pacient_phone").attr('disabled','disabled');
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

  $("form#new_appointment").on('submit', function(){
    $.ajax({
      data: $(this).serialize(),
      url: $(this).attr('action'),
      type: $(this).attr('method'),
      dataType: 'json'
    }).success(function(json) {

      if(json.errors == true){
        alert('Preencha os campos obrigatórios');
      } else {
        window.location.replace(json.url);
      }
    });
    return false;
  });

  $("#appointment-window").on('hidden', function() {
    $("#appointment_record_id").removeAttr('disabled');
    $("#appointment_record_pacient_name").removeAttr('disabled');
    $("#appointment_record_pacient_phone").removeAttr('disabled');
    $("#appointment_health_insurance_id").removeAttr('disabled');
    $(".btn-primary").show();
    $("#appointment_record_id").val("");
    $("#appointment_record_id").trigger("change");
  });

  $("#appointment-window").on('shown', function() {
    dateArr = $("#appointment_scheduled_at").val().split(" ");
    hourArr = dateArr[1].split(":");
    dateArr = dateArr[0].split("/");

    appDate = new Date(dateArr[2],(dateArr[1]-1),dateArr[0]);
    appDate.setHours(hourArr[0],hourArr[1],0,0);
    now = new Date();
    //acessando consulta no passado?
    if(appDate < now) {
      $("#appointment_record_id").attr('disabled','disabled');
      $("#appointment_record_pacient_name").attr('disabled','disabled');
      $("#appointment_record_pacient_phone").attr('disabled','disabled');
      $("#appointment_health_insurance_id").attr('disabled','disabled');
      $("#last_appointment_date").hide();
      $(".btn-primary").hide();
    }
  });

  var setDate = function (date) {
    $("#appointment_scheduled_at").val(date);
  };

  $("a.free-spot-link").on('click', function (e) {
    setDate( $(e.currentTarget).parent().data("date") );
    $("form#new_appointment").attr('action', 'appointments/');
    $("form#new_appointment").attr('method', 'post');
    $("#appointment-window").modal();
  });

  $("a.busy-spot-link").on('click', function (e) {
    app_id = $(e.currentTarget).parent().data("appointment");
    $("form#new_appointment").attr('action', 'appointments/' + app_id);
    $("form#new_appointment").attr('method', 'put');

    setDate( $(e.currentTarget).parent().data("date") );
    $.ajax({
      url: "/appointments/" + app_id,
      dataType: 'json'
    }).success(function(appointment) {
        $("#appointment_record_id").val(appointment.record_id);
        $("#appointment_record_id").trigger("change");
        $("#appointment_health_insurance_id").val(appointment.health_insurance_id);
      });
    $("#appointment-window").modal(); 
  });

}