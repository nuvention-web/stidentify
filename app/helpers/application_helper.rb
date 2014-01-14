module ApplicationHelper

  def valid_email?(email)
    match = (/([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})/i =~ email)
    match.nil? ? false : true
  end


end

