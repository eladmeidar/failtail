var Theme = {
  activate: function(name) {
    window.location.hash = 'themes/' + name
    Theme.loadCurrent();
  },

  loadCurrent: function() {
    var hash = window.location.hash;
    if (hash.length > 0) {
      matches = hash.match(/^#themes\/([a-z0-9\-_]+)$/);
      if (matches && matches.length > 1) {
        $('#current-theme').attr('href', '/stylesheets/themes/' + matches[1] + '/style.css');
      } else {
        alert('theme not valid');
      }
    }
  }
}

$(document).ready(function() {
  Theme.loadCurrent();
  $.localScroll();
  $('.table :checkbox.toggle').each(function(i, toggle) {
    $(toggle).change(function(e) {
      $(toggle).parents('table:first').find(':checkbox:not(.toggle)').each(function(j, checkbox) {
        checkbox.checked = !checkbox.checked;
      })
    });
  });
});