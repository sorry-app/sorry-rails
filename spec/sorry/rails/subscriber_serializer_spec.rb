RSpec.describe Sorry::Rails::SubscriberSerializer do

    # Mock a subscriber / user to serialize
    # during the tests.
    let(:current_user) { double('User') }

    describe '#to_json' do
        # Loop over the attributes to check each.
        described_class::SERIALIZEABLE_ATTRIBUTES.each do |attribute|
            # Context for this attribute.
            context "when serializing #{attribute}" do
                # Get the JSON hash for testing, only include
                # a single attribute at a time, easier mocking for tests.
                subject { described_class.new(current_user).to_json([attribute]) }

                context 'the resulting value' do
                    # Get the payload result for testing.
                    subject { JSON.parse(super()).fetch(attribute.to_s) }

                    context 'when customized' do
                        # Mock the custom method result.
                        let(:custom_method_result) { Faker::Lorem.sentence }

                        context 'when a customer proc' do
                            # Stage the user/config for the method.
                            before(:each) do
                                # Allow the user to receive the method.
                                allow(current_user).to receive(:value_through_proc).and_return(custom_method_result)

                                # Mock the method as a Proc.
                                Sorry::Rails.configuration.send(:"#{attribute}_method=", Proc.new { |user| user.value_through_proc })
                            end

                            # Expect the custom result.
                            it { is_expected.to eq(custom_method_result) }
                        end

                        context 'when a custom method name' do
                            # Mock a custom method name.
                            let(:custom_method_name) { Faker::Lorem.word.to_sym }

                            # Stage the user/config for the method.
                            before(:each) do
                                # Allow the user to receive the method.
                                allow(current_user).to receive(custom_method_name).and_return(custom_method_result)

                                # Add the method to the config.
                                Sorry::Rails.configuration.send(:"#{attribute}_method=", custom_method_name)
                            end

                            # Expect the custom result.
                            it { is_expected.to eq(custom_method_result) }
                        end
                    end

                    context 'when the default method' do
                        # Mock the attribute method on the model.
                        before(:each) { allow(current_user).to receive(attribute).and_return(Faker::Lorem.sentence) }

                        # Is the users own attribute.
                        it { is_expected.to eq(current_user.send(attribute)) }
                    end

                    context 'when no matching method on model' do
                        # Remove the method from the model.
                        before(:each) { allow(current_user).to receive(:respond_to?).with(attribute).and_return(false) }

                        it 'does not include the attribute' do
                            # Expect no matching key in the hash.
                            expect { subject }.to raise_error(KeyError)
                        end
                    end
                end
            end
        end

        context 'when passed non-serializeable attribute name' do
            # Ask for JSON with a random attribute name not
            # found in the SERIALIZEABLE_ATTRIBUTES constant.
            subject { described_class.new(current_user).to_json([Faker::Lorem.word]) }

            it 'raises a custom error' do
                # Expect an error to be thrown.
                expect { subject }.to raise_error(Sorry::Rails::SubscriberSerializer::UnserializableAttributeError)
            end
        end
    end

end
