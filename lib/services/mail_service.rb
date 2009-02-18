module Services
  class MailService < Service::Base
    
    appear_in :memberships
    
    def report
      Notifier.deliver_occurence_report(settings.service_owner.user, occurence)
    end
    
  end
end