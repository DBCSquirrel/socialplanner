window.Facebook = {
  getFriendsData: function(callback) {
    FB.api('/me/friends?fields=id,name,picture', callback);
  },
  createFriendCheckbox: function(friend_data) {
    var html = '<div class="user-card">';
    html += '<img src="' + friend_data.picture.data.url + '">';
    html +=  "<input type='checkbox' name='invite_to_event' value='" + friend_data.id + "'>";
    html += '<span class="user-name">' + friend_data.name + '</span>';
    html += '</div>';

    return $(html);
  }
}
