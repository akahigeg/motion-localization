# -*- coding: utf-8 -*-

require 'rake'
require 'rspec'
require 'fileutils'

describe 'motion-localization' do
  before(:all) do
    @rake = Rake::Application.new
    Rake.application = @rake
    Rake.application.rake_require("motion-localization", [File.join(File.dirname(__FILE__), '..', 'lib')])

    @lang_dir = File.join('resources', 'en.lproj')
    @info_plist = File.join(@lang_dir, 'InfoPlist.strings')
    @localizable = File.join(@lang_dir, 'Localizable.strings')

    @tmp_dir = File.join(File.dirname(__FILE__), 'for_test_dir')

    FileUtils.mkdir_p @tmp_dir
    Dir.chdir @tmp_dir
    FileUtils.mkdir_p 'resources'

    ENV['silent'] = 'true'
  end

  after(:all) do
    FileUtils.rm_rf 'resources'
    ENV['silent'] = nil
  end

  describe "rake localization:create" do
    context "when execute with lang_code=en" do
      before do
        ENV['lang_code'] = 'en'
        @rake["localization:create"].execute
      end

      it "en.lproj dir should be created." do
        File.exist?(@lang_dir).should be_true
      end

      describe "en.lproj/InfoPlist.strings" do
        subject {File.exist?(@info_plist)}
        it { expect{subject}.to be_created }

        subject {File.read(@info_plist)}
        it { should include('CFBundleName')}
        it { should include('YourAppName')}
      end

      it "en.lproj/Localizable.strings should be created." do
        File.exist?(@localizable).should be_true
      end

      it "ENV['lang_code'] should be cleared at finish" do
        ENV['lang_code'].should be_nil
      end
    end

    context "when execute with lang_code=ja" do
      before do
        ENV['lang_code'] = 'ja'
        @rake["localization:create"].execute

        @ja = {:dir => File.join('resources', 'ja.lproj')}
        @ja[:info_plist] = File.join(@ja[:dir], 'InfoPlist.strings')
        @ja[:localizable] = File.join(@ja[:dir], 'Localizable.strings')
      end

      it "ja.lproj dir should be created." do
        File.exist?(@ja[:dir]).should be_true
      end

      it "ja.lproj/InfoPlist.strings should be created." do
        File.exist?(@ja[:info_plist]).should be_true
      end

      it "ja.lproj/Localizable.strings should be created." do
        File.exist?(@ja[:localizable]).should be_true
      end
    end

    context "when localization files already exist" do
      before do
        ENV['lang_code'] = 'en'
        @rake["localization:create"].execute

        File.open(@info_plist, 'w') do |f|
          f.puts('CFBundleName = "ChangedName";')
        end

        File.open(@localizable, 'w') do |f|
          f.write('"some_key" = "some_value"')
        end

        ENV['lang_code'] = 'en'
        @rake["localization:create"].execute
      end

      it "InfoPlist.strings should not change." do
        File.read(@info_plist).should include('ChangedName')
      end

      it "Localizable.strings should not change." do
        File.read(@localizable).should include('some_key')
      end
    end

    context "when lang_code is not specified" do
      it "should raise error" do
        expect{@rake["localization:create"].execute}.to raise_error(RuntimeError)
      end
    end

    context "when resources dir is not exist" do
      before(:all) do
        ENV['lang_code'] = 'en'
        FileUtils.rm_rf 'resources'
      end

      after(:all) do
        FileUtils.mkdir_p 'resources'
      end

      it "should raise error" do
        expect{@rake["localization:create"].execute}.to raise_error(RuntimeError)
      end
    end
  end
end

# for matchar
def created?
  true
end
