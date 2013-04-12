class Agenda
  constructor: (@id)->

  getHtml: (date)->
    $.ajax(
      url: "/agendas/#{@id}"
      data:
        date: date
    ).done (data) ->
      $("div#agenda").html data
      bindLinks()
      setupDialog()

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