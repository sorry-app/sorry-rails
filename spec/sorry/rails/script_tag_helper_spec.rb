# frozen_string_literal: true

RSpec.describe Sorry::Rails::ScriptTagHelper, type: :helper do

    # Include the helper methods for testing.
    include described_class

    # Mock a page identity to be used.
    let(:page_id) { Faker::Lorem.characters(number: 8) }
    let(:script_nonce) { SecureRandom.hex }

    describe '#sorry_script_tag' do
        # Get the resulting tag for testing.
        subject { sorry_script_tag('page_id' => page_id, 'nonce' => script_nonce) }

        # Expect string return.
        it { is_expected.to be_a(String) }
        it { is_expected.to be_html_safe }
        it {
            # Expect an asynchronous JavaScript tag.
            is_expected.to have_tag('script[async]', with: {
                # Pointing at the latest version.
                src: "https://code.sorryapp.com/status-bar/#{Sorry::Rails::PLUGIN_VERSION}/status-bar.min.js",
                # With the configured page identity.
                'data-for': page_id,
                nonce: script_nonce
            })
        }

        describe 'subscriber_payload' do
            # The subscribe payload tag id.
            let(:subscriber_payload_tag) { 'script[id="sorry-subscriber-data"]' }

            context 'without current_user method' do
                # IT should not include the payload
                it { is_expected.to_not have_tag(subscriber_payload_tag) }
            end

            context 'with current_user method' do
                # Make the configured user method available, and
                # have it return the mock user.
                before(:each) do
                    # Mock the method onto the test class.
                    allow(self).to receive(Sorry::Rails.configuration.current_user_method).and_return(mock_user)
                end

                context 'and no user' do
                    # Mock no user.
                    let(:mock_user) { nil }

                    # IT should not include the payload
                    it { is_expected.to_not have_tag(subscriber_payload_tag) }
                end

                context 'and user is signed in' do
                    # Mock a user object with an email address
                    # we can pretend is signed in.
                    let(:mock_user) { double('User', email: Faker::Internet.email) }

                    # Expect the subscriber payload
                    it 'contains the expect payload tag' do
                        # Mock the JSON payload for the user.
                        subscriber_payload = Sorry::Rails::SubscriberSerializer.new(mock_user).to_json

                        # Check for the script tag.
                        is_expected.to have_tag(subscriber_payload_tag) do
                            # Check the serializer JSON payload.
                            with_text(/window.SorryAPIOptions = { \"subscriber\": #{subscriber_payload} };/)
                        end
                    end
                end
            end
        end
    end

end
