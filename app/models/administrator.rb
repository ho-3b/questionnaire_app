class Administrator < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # 管理者は既存の管理者ユーザーによる招待制
  # メールアドレスのみで作成でき、認証メールのリンクでパスワードを設定する
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable
  VALID_PASSWORD_REGEX = /\A^[a-zA-Z0-9!-\/:-@¥\[-`{-~]+\z/

  attr_accessor :current_password, :new_password, :new_password_confirmation, :role_ids

  # create時とupdate時
  validates :email, presence: true,
            email: true,
            uniqueness: true,
            length: { maximum: 255 }, unless:  -> { validation_context == :session }

  # パスワード登録（認証）時とパスワードを忘れた時
  validates :password,
            presence: true,
            format: {with: VALID_PASSWORD_REGEX},
            length: {minimum: 6},
            confirmation: true,
            on: :password_register

  # パスワード変更時
  validates :new_password,
            presence: true,
            format: {with: VALID_PASSWORD_REGEX},
            length: {minimum: 6},
            confirmation: true,
            on: :password_update
  validates :current_password, presence: true, on: :password_change
  validate :current_password_correct, on: :password_change

  # ログイン時のバリデーション
  validates :email, presence: true, on: :session
  validates :password, presence: true, on: :session

  def authenticate
    result = if valid?(:session)
               resource = Administrator.find_by(email: email)
               if resource && resource.valid_password?(password)
                 resource
               else
                 errors.add(:password, :invalid)
                 false
               end
             else
               false
             end
    clean_up_passwords
    result
  end

  def is_confirmation_period_expired?
    self.confirmation_period_expired?
  end

  def password_required?
    super if confirmed?
  end

  def change_password!
    validate!(:password_change)
    self.password = self.new_password
    save!(validate: false)
  end

  private
    def current_password_correct
      unless valid_password?(self.current_password)
        errors.add(:current_password, :invalid)
      end
    end
end
