require 'spec_helper'

describe 'restic' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context 'restic class without any parameters' do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('restic::install') }

          it { is_expected.to contain_package('restic').with_ensure('latest') }
        end
      end
    end
  end
end
