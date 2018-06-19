class CreateUserAndTeam
  include ActiveModel::Model
  define_model_callbacks :save, only: :after
  after_save :create_team
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def save
    run_callbacks :save do
      @user.save
    end
  end

  private

  def create_team
    team = Team.new({ name: @user.name, color: '#ffffff' })
    team.users << @user
    team.save
  end
end
