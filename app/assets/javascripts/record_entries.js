$(function() {
  $("a.history-link").on('click', function (e) {
    entry_id = $(e.currentTarget).data("entry");
    $.ajax({
      url: "/record_entries/" + entry_id,
    }).success(function(entry_view) {
      $("div#entry-body").html(entry_view);
      $("div#entry-window").modal();
    }); 
  });

  $("a.edit-history-link").on('click', function (e) {
    entry_id = $(e.currentTarget).data("entry");
    $.ajax({
      url: "/record_entries/" + entry_id + "/edit",
    }).success(function(entry_view) {
      $("div#entry-body").html(entry_view);
      $("div#entry-window").modal();
    }); 
  });
});