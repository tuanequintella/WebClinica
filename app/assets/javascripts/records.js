$(function() {
  $("a.record-link").on('click', function (e) {
    app_id = $(e.currentTarget).data("appointment");
    
    $.ajax({
      url: "/record_entries/new?appointment_id=" + app_id,
    }).success(function(entry_view) {
      $("div#pacient-record").html(entry_view);
    }); 
  });
});