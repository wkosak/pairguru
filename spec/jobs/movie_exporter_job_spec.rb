require 'rails_helper'

RSpec.describe MovieExporterJob, type: :job do
  let(:user) { create :user }
  subject(:job) { described_class.perform_now(user.id) }

  it 'should deliver email' do
    expect { job }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

  pending ".generate_csv method test missing"
end
