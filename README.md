# motion-localization

To add localization rake task to your RubyMotion project.

## Installation

Add this line to your application's Gemfile:

    gem 'motion-localization'

And then execute:

    $ bundle

And add this line to your application's Rakefile:

    require 'motion-localization'

## Usage

### Creating localization files

Move to your RubyMotion project directory and run rake task `localization:create` with `lang_code`

    rake localization:create lang_code=en
    rake localization:create lang_code=ja

## After creating localization files

Google it for more informatoin.

### Edit localization files

* InfoPlist.strings: App name localization.
* Localizable.strings: In app string localization.

### Use localize method in your code

    NSBundle.mainBundle.localizedStringForKey(key, value:default, table:nil)

#### with BubbleWrap

    BubbleWrap.localized_string(:foo, 'fallback')
    BW.localized_string(:foo, 'fallback')

#### with sugercube

    "hello".localized  # => NSBundle.mainBundle.localizedStringForKey("hello", value:nil, table:nil)
    "hello"._          # == "hello".localized
    "hello".localized('Hello!', 'hello_table')  # => ...("hello", value:'Hello!', table:'hello_table')

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
