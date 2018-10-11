$(document).on('turbolinks:load', function() {

  var channel = $('span#channel').data('channel');

  if(channel){
    var profile_1_id = channel.split(":")[1];
    var profile_2_id = channel.split(":")[2];

    App['messages_'+profile_1_id+'_'+profile_2_id] = App.cable.subscriptions.create(
      {
        channel:      'MessagesChannel',
        profile_1_id: profile_1_id,
        profile_2_id: profile_2_id
      },
      {
        received: function(data){
          window.messages.fetchMessages();
        }
      }
    );
  }

});
