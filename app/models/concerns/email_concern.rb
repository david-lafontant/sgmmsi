module EmailConcern
  include ActiveSupport::Concern

  def display_email(id)
    User.find(id).email
  end
end
