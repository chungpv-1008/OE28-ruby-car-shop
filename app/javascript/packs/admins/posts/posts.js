$(document).on('turbolinks:load', function() {
  $('.btn-activated').click(function() {
    var post_id = this.getAttribute("post_id");
    var url = '/admins/posts/change_activated';
    $.ajax({
      method: 'POST',
      dataType: 'json',
      url: url,
      dataType: 'script',
      data: {
        id: post_id,
      }
    });
  });
})
