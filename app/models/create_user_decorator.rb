class CreateUserDecorator
  include ActiveModel::Model
  define_model_callbacks :save, only: :after
  after_save :create_team
  attr_accessor :user

  def save
    User.transaction do
      run_callbacks :save do
        user.save!
      end
    end
    rescue
      false
  end

  private

  def create_team
    team = Team.new({ name: user.name, color: '#ffffff' })
    team.users << user
    team.save!
  end
end
