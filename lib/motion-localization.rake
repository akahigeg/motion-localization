desc "create localization files (options: lang_code=xx )."
namespace :localization do
  task :create do
    raise "require argument 'lang_code=[lang_code]' ex. lang=en" if ENV['lang_code'].nil?
    raise "can't find resources dir." unless File.exist? 'resources'

    lang_dir = File.join('resources', "#{ENV['lang_code']}.lproj")
    info_plist = File.join(lang_dir, 'InfoPlist.strings')
    localizable = File.join(lang_dir, 'Localizable.strings')

    created_files = []
    existed_files = []

    if File.exist?(lang_dir)
      existed_files << lang_dir
    else
      Dir.mkdir(lang_dir)
      created_files << lang_dir
    end

    if File.exist?(info_plist)
      existed_files << info_plist
    else
      File.open(info_plist, 'w') do |f|
        f.puts('CFBundleName = "YourAppName";')
        f.puts('CFBundleDisplayName = "YourAppName";')
      end
      created_files << info_plist
    end

    if File.exist?(localizable)
      existed_files << localizable
    else
      File.open(localizable, 'w') do |f|
        f.puts('"key" = "localized string";')
      end
      created_files << localizable
    end

    unless ENV['silent']
      created_files.each do |f|
        STDOUT.puts "#{f} is created."
      end
      existed_files.each do |f|
        STDOUT.puts "#{f} is already exist."
      end
    end

    ENV['lang_code'] = nil
  end
end
