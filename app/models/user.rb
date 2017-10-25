class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :timeoutable

  belongs_to :account, optional: true

  before_create do
    self.account = Account.create! unless account
  end

  def workflows
    account.workflows
  end
end
