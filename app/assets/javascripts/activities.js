// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on('turbolinks:load', function() {
  const activityItems = $('.activityItem');
  for (i=0; i< activityItems.length; i++){
    if($(activityItems[i]).is(':checked')){
      var el = $('#' + $(activityItems[i])[0].id + '.activityDropdown')
      el.css('visibility', 'visible');
      el.val($('#' + $(activityItems[i])[0].id).data("skill"))
    }
  }

  $('.activityItem').click((event)=>{
    if($(event.target).is(':checked')) {
      $('#' + event.target.id + '.activityDropdown').css('visibility', 'visible')
    } else {
      $('#' + event.target.id + '.activityDropdown').css('visibility', 'hidden')
    }
  });
});
