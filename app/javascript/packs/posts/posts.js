$(document).on('turbolinks:load', function() {
  $("#sort").on("change", function() {
    var sort_id = $(this).val();
    var url = '/posts/update_index';
    $.ajax({
      method: 'POST',
      dataType: 'json',
      url: url,
      dataType: 'script',
      data: {
        sort_id: sort_id,
      }
    });
  });
});
