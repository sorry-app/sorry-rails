# frozen_string_literal: true

RSpec.describe Sorry::Rails::Configuration do

    # Get an instance for testing.
    subject { described_class.new }

    describe '#current_user_method' do
        # Get the current user method.
        subject { super().current_user_method }

        context 'by default' do
            # Check the Devise focussed default.
            it { is_expected.to eq(:current_user) }
        end
    end

end
