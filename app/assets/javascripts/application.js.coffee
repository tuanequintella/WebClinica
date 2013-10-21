# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# the compiled file.
#
# WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
# GO AFTER THE REQUIRES BELOW.
#= require jquery
#= require jquery_ujs
#= require jquery_nested_form
# require_tree .

$ ->
  $("form.search input").keyup ->
    form = $("form.search")
    $.ajax(
      url: form.attr("action")
      data: form.serialize()
    ).done (data) ->
      $("table tbody").html data

$ ->
  $('.datepicker').datepicker({language: 'pt-BR', endDate: new Date(), todayHighlight: true, autoclose: true })
  $('.timepicker').timepicker({minuteStep: 5, showMeridian: false})
  $('.dropdown-toggle').dropdown()
  $('.select2').select2()

$(document).on 'nested:fieldAdded', (event) ->
  fields = event.field
  dateFields = fields.find('.datepicker')
  timeFields = fields.find('.timepicker')
  dropFields = fields.find('.dropdown-toggle')
  selectFields = fields.find('.select2')

  dateFields.datepicker({language: 'pt-BR', endDate: new Date(), todayHighlight: true, autoclose: true })
  timeFields.timepicker({minuteStep: 5, showMeridian: false, defaultTime: '12:00'})
  dropFields.dropdown()
  selectFields.select2()