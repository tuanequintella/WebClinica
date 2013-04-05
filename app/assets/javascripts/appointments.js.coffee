class NewAppointment
  constructor: (agenda_id, date)->
    @date = date
    $.ajax(
      url: "/appointments/new",
      data:
        date: date
        agenda_id: agenda_id
    ).done (data) ->
      $("div#dialog-form").html data
      
window.NewAppointment = NewAppointment

window.setupDialog = () ->
  $("#dialog-form" ).dialog
    autoOpen: false,
    height: 'auto',
    width: 'auto',
    modal: true

window.bindRecord = () ->
  $("#appointment_record_id").on 'change', () ->
    if $(this).val() != ""
      $.ajax
        url: "/records/" + $(this).val()
        dataType: 'json'
        success: (data) ->
          $('#pacient_name').val(data['pacient']['name'])
          
          $('#pacient_health_insurance').html("<option value>Selecione uma opção</option>")
          
          $(window.health_insurances).each (index) ->
            if this.name == "Sem convênio (particular)"
              $('#pacient_health_insurance').append("<option value='#{this.id}'>#{this.name}</option>")  
            else
              if this.id == data['pacient']['health_insurance_id']
                $('#pacient_health_insurance').append("<option value='#{this.id}'>#{this.name}</option>")
                #$('#pacient_health_insurance').val(data['pacient']['health_insurance']['name'])
          $('#pacient_phone').val(data['pacient']['phone'])
          $('#record_status').val(data['status'])
          if(data['last_appointment'] != undefined)
            $('div#last_appointment_date').show()
            app_date =  new Date(data['last_appointment']['scheduled_at'])
            limit_date = new Date()
            limit_date.setDate(limit_date.getDate()-30)
            $('#record_last_appointment').val(app_date.getDate() + '/' + app_date.getMonth() + '/' + app_date.getFullYear())
            if(app_date > limit_date)
              $('div#appointment-date-warning').show()
            else
              $('div#appointment-date-warning').hide()
          else
            $('#record_last_appointment').val("")
            $('div#last_appointment_date').hide()
            $('div#appointment-date-warning').hide()
            
    else
      $('#pacient_health_insurance').html("<option value>Selecione uma opção</option>")
      $(window.health_insurances).each (index) ->
        $('#pacient_health_insurance').append("<option value='#{this.id}'>#{this.name}</option>")
      $('#pacient_name').val("")
      $('#pacient_phone').val("")
      $('#record_status').val("Sem ficha")
      $('#record_last_appointment').val("")
      $('div#last_appointment_date').hide()
