window.bindRecord = () ->
  $("#appointment_record_id").on 'change', () ->
    if $(this).val() != ""
      $.ajax
        url: "/records/" + $(this).val()
        dataType: 'json'
        success: (data) ->
          $('#record_pacient_name').val(data['pacient']['name'])
          $('#record_pacient_name').attr('readonly', 'readonly')
          
          $('#health_insurance_id').html("<option value>Selecione uma opção</option>")
          
          $(window.health_insurances).each (index) ->
            if this.name == "Sem convênio (particular)"
              $('#health_insurance_id').append("<option value='#{this.id}'>#{this.name}</option>")  
            else
              if this.id == data['pacient']['health_insurance_id']
                $('#health_insurance_id').append("<option value='#{this.id}'>#{this.name}</option>")
          $('#record_pacient_phone').val(data['pacient']['phone'])
          $('#record_status').val(data['status'])
          if(data['last_appointment'] != undefined)
            $('div#last_appointment_date').show()
            app_date =  new Date(data['last_appointment']['scheduled_at'])
            limit_date = new Date()
            limit_date.setDate(limit_date.getDate()-30)
            $('#record_last_appointment').val(app_date.getDate() + '/' + app_date.getMonth() + '/' + app_date.getFullYear())
            if(app_date > limit_date)
              valid_date = new Date();
              valid_date.setDate(app_date.getDate()+30) 
              new_text = $('div#appointment-date-warning').text().replace(/(\d{1,2}\/\d{1,2}\/\d{4})/, (valid_date.getDate() + "/" + valid_date.getMonth() + "/" + valid_date.getFullYear()) )
              $('div#appointment-date-warning').text(new_text)
              $('div#appointment-date-warning').show()
            else
              $('div#appointment-date-warning').hide()
          else
            $('#record_last_appointment').val("")
            $('div#last_appointment_date').hide()
            $('div#appointment-date-warning').hide()
            
    else
      $('#health_insurance_id').html("<option value>Selecione uma opção</option>")
      $(window.health_insurances).each (index) ->
        $('#health_insurance_id').append("<option value='#{this.id}'>#{this.name}</option>")
      $('#record_pacient_name').val("")
      $('#record_pacient_name').removeAttr("readonly")
      $('#record_pacient_phone').val("")
      $('#record_status').val("new")
      $('#record_last_appointment').val("")
      $('div#last_appointment_date').hide()
