RSpec.describe Sorry::Rails do

    describe "#configure" do
        # Mock some detailed to pass to the config.
        let(:page_id) { Faker::Lorem.characters(8) }

        context "when passed a block" do
            subject do
                # Invoke the configure with
                # a block, setting a mock Page ID.
                described_class.configure do |config|
                    # Set the mock page identity.
                    config.page_id = page_id
                end
            end

            # Check a configuration instance records.
            it { is_expected.to be_a(described_class::Configuration) }

            describe "the configured page_id" do
                # Get the page if for testing.
                subject { super().page_id }

                # Is the one passed in.
                it { is_expected.to eq(page_id) }
            end
        end
    end

    describe "#configuration" do
        # Get the configuration for testing.
        subject { described_class.configuration }

        context "when previously configured" do
            # Mock the configuration.
            let(:configuration) { described_class::Configuration.new }

            # Put the configuration in place.
            before(:each) { described_class.configuration = configuration }

            # Returns a config class.
            it { is_expected.to be(configuration) }
        end

        context "when not configured" do
            # Put the configuration in place.
            before(:each) { described_class.configuration = nil }

            # It has not config.
            it { is_expected.to be_nil }
        end
    end    

    describe "version number" do
        # Get version for testing.
        subject { described_class::VERSION }

        # Should be present.
        it { is_expected.not_to be_nil }
    end
    
end
