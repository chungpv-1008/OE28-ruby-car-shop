$(document).on('turbolinks:load', function() {
  $('#favorite_list_link').click(function() {
    var post_id = $('#post_id').val();
    var url = '/favorite_lists/update';
    $.ajax({
      method: 'POST',
      dataType: 'json',
      url: url,
      data: {
        post_id: post_id,
      }
    });
  });
})
