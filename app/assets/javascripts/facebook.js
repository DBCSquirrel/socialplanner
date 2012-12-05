window.Facebook = {
  getFriendsData: function(callback) {
    FB.api('/me/friends?fields=id,name,picture', callback);
  },
  createFriendCheckbox: function(friend_data) {
    var html = '<div class="user-card">';
    html += '<input type="checkbox" name="acceptable_invites[]" value="' + friend_data.id + '">';
    html += '<img src="' + friend_data.picture.data.url + '">';
    html += '<span class="user-name">' + friend_data.name + '</span>';
    html += '</div>';

    return $(html);
  }
}