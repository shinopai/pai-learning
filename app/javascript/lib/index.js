$(document).on('turbolinks:load', function () {
  // show answer
  $('.show-answer').on('click', function () {
    $('#answer' + $(this).data('id')).toggleClass('hidden');
  })

  // show create collection form
  $('#show-collection-form').on('click', function () {
    $('#create-collection-form').toggleClass('hidden');
  })

  // show collection list
  $('#show-collection-list').on('click', function () {
    $('#collection-list').toggleClass('hidden');
  })

  // menu for sp
  $('#show-dropdown').on('click', function () {
    $('#dropdown').toggleClass('hidden');
  })

  $('#create-collection-form-sp-menu').on('click', function () {
    $('#create-collection-form-sp').toggleClass('hidden');
  })
});
