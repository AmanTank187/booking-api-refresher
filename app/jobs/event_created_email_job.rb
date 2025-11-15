class EventCreatedEmailJob < ApplicationJob
  queue_as :default

  def perform(*args)
    event = args[0]
    "Email has been sent to #{event.creator.email} as #{event.title} is now created"
  end
end
