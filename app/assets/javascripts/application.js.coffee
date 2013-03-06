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
#
#= require jquery
#= require jquery_ujs
#= require jquery.ui.all
#= require twitter/bootstrap
#= require jquery_nested_form
#= require_tree .

class Agenda
  constructor: (@id)->

  getHtml: (date)->
    $.ajax(
      url: "/agendas/#{@id}"
      data:
        date: date
    ).done (data) ->
      $("div#agenda").html data
      $("div.clickme").dblclick ->
        alert("oi")

  enableConfigure: ->
    $.ajax(
      url: "/agendas/#{@id}"
    ).done ->
      $("div#editAgenda").html


class AgendaApp
  constructor: (@today)->
    @btnConfigure = $("a#btn-configure")
    @selectDate = $("input#date")
    @selectDate.hide()
    $("select#doctor").change (event) =>
      if $("select#doctor option:selected").val() != ""
        @currentAgenda = new Agenda($("select#doctor option:selected").val())
        @currentAgenda.getHtml(@today)

        @btnConfigure.click =>
          @currentAgenda.enableConfigure()

        @btnConfigure.attr("disabled",false)
        @selectDate.show()
        @selectDate.change (event) =>
          @currentAgenda.getHtml($("input#date").val())
      else
        @btnConfigure.attr("disabled", true)
        @selectDate.hide()
        @currentAgenda = null
        $("div#agenda").html ""

window.AgendaApp = AgendaApp

$ ->
  $("form.search input").keyup ->
    form = $("form.search")
    $.ajax(
      url: form.attr("action")
      data: form.serialize()
    ).done (data) ->
      $("table tbody").html data
$ ->
  #$(".datepicker").setDefaults( $.datepicker.regional[ "pt" ] )
  $(".datepicker").datepicker() #{showOn: "button", buttonImage: "assets/images/calendar.png", buttonImageOnly: true }
  $(".datepicker").datepicker("option", "dateFormat", "dd/mm/yy")

