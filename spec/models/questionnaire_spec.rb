require 'rails_helper'

RSpec.describe Questionnaire, type: :model do
  describe '#create' do
    let(:questionnaire) { FactoryBot.build(:questionnaire) }

    context '登録できる時' do
      it '全ての項目が入力されていれば、登録ができること' do
        expect(questionnaire).to be_valid
      end

      it '終了時刻がなくても登録できること' do
        questionnaire.terminates_at = nil
        expect(questionnaire).to be_valid
      end
    end

    context '登録できない時' do
      it 'タイトルがないと登録できないこと' do
        questionnaire.title = nil
        expect(questionnaire.errors[:title].any?).to be_truthy
      end
    end

  end

end
