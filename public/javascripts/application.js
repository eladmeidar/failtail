$(document).ready(function() {
    
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
});