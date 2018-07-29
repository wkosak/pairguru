require "rails_helper"

describe User do
  it { is_expected.to allow_value("+48 999 888 777").for(:phone_number) }
  it { is_expected.to allow_value("48 999-888-777").for(:phone_number) }
  it { is_expected.to allow_value("48 999-888-777").for(:phone_number) }
  it { is_expected.not_to allow_value("+48 aaa bbb ccc").for(:phone_number) }
  it { is_expected.not_to allow_value("aaa +48 aaa bbb ccc").for(:phone_number) }
  it { is_expected.not_to allow_value("+48 999 888 777\naseasd").for(:phone_number) }

  describe 'scopes' do
    describe 'top_commenters' do
      let!(:user1) { create(:user) }
      let!(:user2) { create(:user) }
      let!(:comments) { create_list(:comment, 3, user: user1, created_at: 3.days.ago) }
      subject { described_class.top_commenters }

      it 'returns only users with comments' do
        expect(subject).to include(user1)
        expect(subject).to_not include(user2)
      end

      it 'returns num_comments' do
        expect(subject.first.num_comments).to eq(3)
      end

      context 'only last week comments' do
        let(:time_in_past) { described_class::TOP_COMMENTERS_PERIOD.ago - 1.day }
        before do
          comments.first.update_attributes created_at: time_in_past
        end

        it 'returns number of last week comments' do
          expect(subject.first.num_comments).to eq(2)
        end
      end
    end
  end
end
