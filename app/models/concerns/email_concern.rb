module EmailConcern
  include ActiveSupport::Concern

  def display_email(id)
    User.find(id).email
  rescue ActiveRecord::RecordNotFound
    errors.add(id, 'id key must exist')
    false
  end
end
