module UserConcern
  include ActiveSupport::Concern

  def user_id_exists
    User.find(user_id)
  rescue ActiveRecord::RecordNotFound
    errors.add(user_id, 'id key must exist')
    false
  end
end
