require 'spec_helper'

describe 'restic' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "restic class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('restic::params') }
          it { is_expected.to contain_class('restic::install').that_comes_before('restic::config') }
          it { is_expected.to contain_class('restic::config') }
          it { is_expected.to contain_class('restic::service').that_subscribes_to('restic::config') }

          it { is_expected.to contain_service('restic') }
          it { is_expected.to contain_package('restic').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'restic class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('restic') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
