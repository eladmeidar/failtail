def path_to(page_name)
  case page_name
  
  when /the homepage/i
    root_path
  when /the registration page/i
    new_account_path
  when /the login page/i
    new_user_session_path
  
  else
    raise "Can't find mapping from \"#{page_name}\" to a path."
  end
end