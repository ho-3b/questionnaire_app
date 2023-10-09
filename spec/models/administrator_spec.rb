require 'rails_helper'

RSpec.describe Administrator, type: :model do
  describe '#save!' do

    context '登録するとき' do
      let(:administrator) { FactoryBot.build(:administrator) }

      context '登録できる時' do
        it 'メールアドレスと権限さえあれば登録ができること' do
          administrator.save!
          expect(administrator.persisted?).to be_truthy
        end
      end

      context '登録できない時' do
        it 'emailが空では登録できないこと' do
          administrator.email = ''
          administrator.valid?
          expect(administrator.errors[:email].any?).to be_truthy
        end

        it 'emailの形式が不正（@がない）だと登録できないこと' do
          administrator.email = 'abc123'
          administrator.valid?
          expect(administrator.errors[:email].any?).to be_truthy
        end

        it 'emailの形式が不正（変な記号を含む）だと登録できないこと' do
          administrator.email = 'a1{,.a@example/.com'
          administrator.valid?
          expect(administrator.errors[:email].any?).to be_truthy
        end

        it '重複したemailが存在する場合登録できないこと' do
          administrator.save!
          another_user = FactoryBot.build(:administrator, email: administrator.email)
          another_user.valid?
          expect(another_user.errors[:email].any?).to be_truthy
        end
      end
    end

    context '更新するとき' do
      before do
        @administrator = FactoryBot.create(:administrator_with_password)
        @administrator.confirm
      end

      context '更新できる時' do
        it 'passwordが空でも更新できること' do
          @administrator.password = ''
          @administrator.save!
          # 例外がraiseされなければよい
        end

        it 'emailを更新するとunconfirmed_emailカラムに登録されること' do
          old_email = @administrator.email
          new_email = 'user2@example.com'
          @administrator.email = new_email
          @administrator.save!
          expect(@administrator.email).to eq old_email
          expect(@administrator.unconfirmed_email).to eq new_email
        end
      end

      context '更新ができないとき' do

      end
    end
  end


  describe '#update' do
    context 'context: password_register（パスワード変更時）' do
      before do
        @administrator = FactoryBot.create(:administrator)
      end

      context '更新ができる時' do
        it 'パスワードと確認が一致していれば更新できること' do
          @administrator.password = 'abcd123'
          @administrator.password_confirmation = 'abcd123'
          expect(@administrator.valid?(:password_register)).to be_truthy
        end
      end

      context '更新ができない時' do
        it 'パスワード登録時はpasswordが空では登録できないこと' do
          @administrator.password = ''
          @administrator.valid?(:password_register)
          expect(@administrator.errors[:password].any?).to be_truthy
        end
      end
    end

    context 'context: password_change（パスワード更新時）' do
      before do
        @administrator = FactoryBot.create(:administrator_with_password)
        @administrator.confirm
      end

      context '更新ができる時' do
        it 'current_passwordが一致していれば更新できること' do
          @administrator.current_password = 'Xb5-+.Fm'
          @administrator.new_password = 'abcd123'
          @administrator.new_password_confirmation = 'abcd123'
          expect(@administrator.valid?(:password_change)).to be_truthy
        end
      end

      context '更新ができない時' do
        it 'current_passwordが空では更新できないこと' do
          @administrator.current_password = ''
          @administrator.valid?(:password_change)
          expect(@administrator.errors[:current_password].any?).to be_truthy
        end

        it 'current_passwordが現在のパスワードと一致しないと更新できないこと' do
          @administrator.current_password = 'aaaaaa'
          @administrator.valid?(:password_change)
          expect(@administrator.errors[:current_password].any?).to be_truthy
        end

        it 'new_passwordが5文字以下であれば登録できないこと' do
          @administrator.new_password = '1234a'
          @administrator.new_password_confirmation = '1234a'
          @administrator.valid?(:password_change)
          expect(@administrator.errors[:new_password].any?).to be_truthy
        end

        it 'new_passwordが全角のときに登録できないこと' do
          @administrator.new_password = '１２３４５A'
          @administrator.new_password_confirmation = '１２３４５A'
          @administrator.valid?(:password_change)
          expect(@administrator.errors[:new_password].any?).to be_truthy
        end

        it 'new_passwordとnew_password_confirmationが不一致では登録できないこと' do
          @administrator.new_password = '12345a'
          @administrator.new_password_confirmation = '123456a'
          @administrator.valid?(:password_change)
          expect(@administrator.errors[:new_password_confirmation].any?).to be_truthy
        end
      end
    end
  end

  describe '#change_password!' do
    before do
      @administrator = FactoryBot.create(:administrator_with_password)
    end

    it 'current_passwordが一致していれば更新できること' do
      # バリデーション通るかどうかはここでは検証しない。更新の結果のみ検証する。
      @administrator.current_password = 'Xb5-+.Fm'
      @administrator.new_password = 'abcd123'
      @administrator.new_password_confirmation = 'abcd123'
      @administrator.change_password!
      expect(@administrator.valid_password?('abcd123')).to be_truthy
    end
  end

  describe '#confirm' do
    it '新規登録→承認のときconfirmed_atに値が入ること、メールアドレス変更→承認のときunconfirmed_emailが消えること' do
      administrator = FactoryBot.create(:administrator)
      administrator.confirm
      expect(administrator.confirmed_at.present?).to be true

      administrator.email = 'user2@example.com'
      administrator.save!
      administrator.confirm

      expect(administrator.email).to eq 'user2@example.com'
      expect(administrator.unconfirmed_email).to be nil
    end
  end

  describe '#authenticate' do
    before do
      @administrator = FactoryBot.create(:administrator_with_password)
      @administrator.confirm
    end
    it '正しいメールアドレスとパスワードを入力すると認証が成功し、ユーザーのインスタンスが返ること' do
      resource = Administrator.new(email: 'user1@example.com', password: 'Xb5-+.Fm')
      auth_user = resource.authenticate
      expect(auth_user.id).to eq @administrator.id
    end
  end
end
