class Comment < ActiveRecord::Base

  validates_presence_of :body
  validates_presence_of :user_id
  validates_presence_of :error_id
  validates_length_of :body, :minimum => 2

  validate :user_must_be_member_of_error_project

  belongs_to :error, :class_name => "::Error"
  belongs_to :user

private

  def user_must_be_member_of_error_project
    if self.user_id and self.error_id
      unless User.find(self.user_id).member?(::Error.find(self.error_id))
        self.errors.add(:user_id, "is not a member of this project")
      end
    end
  end

end