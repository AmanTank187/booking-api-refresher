class EventCreatedEmailJob < ApplicationJob
  queue_as :default

  def perform(event)
    debugger
    "Email has been sent to #{event.creator.email} as #{event.title} is now created"
  end
end
