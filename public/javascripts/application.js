var currentContent ="content1";
var switching = false;

var switchContent = (function(sender){
  var contentBlock = $(sender).attr("rel");
  if(!switching && contentBlock!=currentContent){
    switching = true;
    $("ul.features a").removeClass("active");
    $("#"+currentContent).fadeOut(500, function(){
      $("#"+contentBlock).fadeIn(1000, function(){
        switching = false;
      });
    });
    $("a[rel='"+contentBlock+"']").addClass("active");
    currentContent = contentBlock;
  }
});

var validateEmail = (function(address){
  var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
  !(reg.test(address) == false);
});

/*
 * DOM Ready
 */
$(document).ready(function() {
  var header    = $('#header'),
      footer    = $('#footer'),
      login     = $('#login'),
      subscribe = $('#subscribe');
  
  //borrowed from jQuery easing plugin
  //http://gsgd.co.uk/sandbox/jquery.easing.php
  $.easing.easeOutQuad = function(x, t, b, c, d) {
    return -c *(t/=d)*(t-2) + b;
  };

  $(".links a", footer).mouseover(function(){
    $(this).stop();
    $(this).animate({ opacity: 1 }, 200);
  });

  $(".links a", footer).mouseout(function(){
    $(this).stop();
    $(this).animate({ opacity: 0.5 }, 200);
  });

  $('#selectAll').click(function(){
    var checked = $('#selectAll').is(':checked');
    $("td input[type='checkbox']").attr('checked', checked);
  });

  $("ul.features a,#header ul li.request a, a.toTab").each(function(){
    $(this).attr("href","javascript:;");
  });

  $("ul.features a").click(function(){
    switchContent(this);
  });

  $("ul li.login a", header).click(function(){
    if (login.hasClass('active')) {
      $(this).html("Login");
      login.fadeOut(500);
      login.removeClass('active');
    } else {
      $(this).html("Hide");
      login.fadeIn(1000);
      login.addClass('active');
      subscribe.fadeOut(250);
      subscribe.removeClass('active');
      $("ul li.subscribe a", header).html("Newsletter");
    }
  });

  $("ul li.subscribe a", header).click(function(){
    if (subscribe.hasClass('active')) {
      $(this).html("Newsletter");
      subscribe.fadeOut(500);
      subscribe.removeClass('active');
    } else {
      $(this).html('Hide');
      subscribe.fadeIn(1000);
      subscribe.addClass('active');
      login.fadeOut(250);
      login.removeClass('active');
      $("ul li.login a", header).html("Login");
    }
  });

  $("a.toTab").click(function(){
    switchContent(this);
  });

  $("ul li.request a", header).click(function(){
    switchContent(this);
    $.scrollTo($("#container"), 1500, {easing:'easeOutQuad'});
  });

  $("form.emailForm").submit(function(){
    var email      = $("#invitation_request_email").attr("value"),
        authentity = $("input[name='authenticity_token']").attr("value");
    $("span.valid").hide();
    $("span.invalid").hide();
    if (validateEmail(email)) {
      var post_data = {
        "invitation_request[email]": email,
        "authenticity_token":        authentity };
      $.post("/invitation_requests.js", post_data, function(data){
        $("span.valid").html("Thank you for your request. You will receive an e-mail very soon!");
        $("span.valid").attr("style","display:block;");
      });
    } else {
      $("span.invalid").html("Please enter a valid e-mail address.");
      $("span.invalid").attr("style","display:block;");
    }
    return false;
  });
  
  /*
   * Clearfield
   */
  $('.clear-field').clearField();
  
  
  /*
   * Table sorter
   */
   $("table.sortable").tablesorter({textExtraction: 'complex'}); 
   $("table.sortable th").filter(function(idx){
       if ($(this).hasClass('sortable')) {
           return false;
       } else {
           return $(this);
       }
   }).unbind('click');
   
}); // End DOM ready
