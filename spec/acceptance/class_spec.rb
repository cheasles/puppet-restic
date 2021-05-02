require 'spec_helper_acceptance'

describe 'restic class' do
  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'work idempotently with no errors' do
      pp = <<-EOS
      class { 'restic': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe package('restic') do
      it { is_expected.to be_installed }
    end
  end
end
