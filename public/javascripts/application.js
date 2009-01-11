// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

document.observe('dom:loaded', function(){
  $$('.shadow').each(function(e){
    e.wrap('div', { 'class': 'shadow-wrapper' });
  });
});
