$(function() {
  $("a.record-link").on('click', function (e) {
    rec_id = $(e.currentTarget).data("record");
    
    $.ajax({
      url: "/records/" + rec_id + "/edit",
    }).success(function(record_view) {
      $("div#pacient-record").html(record_view);
    }); 
  });
});