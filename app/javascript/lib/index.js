$(document).on('turbolinks:load', function () {
  $('.show-answer').on('click', function () {
    $('#answer' + $(this).data('id')).toggleClass('hidden');
  })
});
