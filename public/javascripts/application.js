var currentContent ="content1";
var switching = false;

$(document).ready(function() {
  //borrowed from jQuery easing plugin
  //http://gsgd.co.uk/sandbox/jquery.easing.php
  $.easing.easeOutQuad = function(x, t, b, c, d) {
    return -c *(t/=d)*(t-2) + b;
  };

  /*var email = new LiveValidation('invitation_request_email');
  email.add(Validate.Presence);
  email.add(Validate.Email);*/

  $("#footer .links a").mouseover(function(){
      $(this).stop();
      $(this).animate( { opacity: 1 }, 200 );
  });
  $("#footer .links a").mouseout(function(){
      $(this).stop();
      $(this).animate( { opacity: 0.5 }, 200);
  });
  $('#selectAll').click(
	function()
  	{
      $("td input[type='checkbox']").attr('checked', $('#selectAll').is(':checked'));
	}
  )

  $("ul.features a,#header ul li.request a, a.toTab").each(function(){
	$(this).attr("href","javascript:;");
  });

  $("ul.features a").click(function(){
      switchContent(this);
    }
  );

  $("#header ul li.login a").toggle(
	function(){
	  $("#header ul li.login a").html("Hide");
	  $("#header ul li.request").hide();
      $("#login").fadeIn(1000);
    },
    function(){
	  $("#header ul li.login a").html("Login");
	  $("#header ul li.request").show();
	  $("#login").fadeOut(500);
	
    }
  );
  $("a.toTab").click(function(){
    switchContent(this);	
  });
  $("#header ul li.request a").click(function(){
	switchContent(this);
    $.scrollTo( $("#container"), 1500,{easing:'easeOutQuad'});	
  });

  $("form.emailForm").submit(function(){
	var email = $("#invitation_request_email").attr("value");
	var authentity = $("input[name='authenticity_token']").attr("value");
	$("span.valid").hide();
	$("span.invalid").hide();
	if(validateEmail(email)){
		$.post("/invitation_requests.js",{ "invitation_request[email]": email, authenticity_token: authentity }, function(data){
		  $("span.valid").html("Thank you for your request. You will receive an e-mail very soon!");
		  $("span.valid").attr("style","display:block;");
		});
	}else{
		$("span.invalid").html("Please enter a valid e-mail address.");
		$("span.invalid").attr("style","display:block;");
	}
	return false;
  });
  
  /* 
   * Autocomplete members
   */
   //$('#membership_email').autocomplete({
   //    source: function(req, add){
   //             //pass request to server
   // 			$.getJSON("/users", req, function(data) {
   //   				//create array for response objects
   // 				var suggestions = [];
   // 				//process response
   // 				$.each(data.users, function(i, val){
   // 				    suggestions.push(val.user.email);
   // 			    });
   // 			    //pass array to callback
   // 			    if (suggestions.length == 0) {
   // 			        suggestions.push('No users found');
   // 			    }
   // 			    add(suggestions);
   // 		    });
   //     },
   //     minLength: 2
   // });
  
}); // End DOM ready


function switchContent(sender){
	var contentBlock = $(sender).attr("rel");
	if(!switching && contentBlock!=currentContent){
	  switching = true;
      $("ul.features a").removeClass("active");
      $("#"+currentContent).fadeOut(500,function(){
	    $("#"+contentBlock).fadeIn(1000,function(){
		  switching = false;
	    });
      });
      $("a[rel='"+contentBlock+"']").addClass("active");
      currentContent = contentBlock;
   }
}

function validateEmail(address) {
   var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
   if(reg.test(address) == false) {
      return false;
   }
   return true;
}

