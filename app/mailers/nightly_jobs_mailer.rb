class NightlyJobsMailer < ActionMailer::Base
  default from: "services@optyn.com"

  def announce_failure(content, method_name)
    mail(to: ["Gaurav Gaglani <gaurav@optyn.com>", "Alen Malkoc <alen@optyn.com>"],
         subject: "Failed running the nightly job of #{method_name}",
         body: content)
  end
end