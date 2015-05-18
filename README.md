# Omniauth::Multipassword

[![Build Status](https://travis-ci.org/jgraichen/omniauth-multipassword.svg?branch=master)](https://travis-ci.org/jgraichen/omniauth-multipassword)
[![Code Climate](https://codeclimate.com/github/jgraichen/omniauth-multipassword/badges/gpa.svg)](https://codeclimate.com/github/jgraichen/omniauth-multipassword)
[![Test Coverage](https://codeclimate.com/github/jgraichen/omniauth-multipassword/badges/coverage.svg)](https://codeclimate.com/github/jgraichen/omniauth-multipassword/coverage)

**omniauth-multipassword** is a [OmniAuth](https://github.com/intridea/omniauth)
strategy that allows to authenticate again different password strategies at once.


## Installation

Add this line to your application's Gemfile:

    gem 'omniauth-multipassword'

Add multipassword compatible omniauth strategies you want to use:

	gem 'omniauth-internal'
	gem 'omniauth-kerberos'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-multipassword


## Usage

```ruby
Rails.application.config.middleware.use OmniAuth::Strategies::MultiPassword, fields: [ :auth_key ] do |mp|
  mp.authenticator :internal
  mp.authenticator :kerberos
end
```


## Options

** title **
The title text shown on default login form.
(default: `"Restricted Access"`)

** fields **
The request parameter names to fetch username and password.
(default: `[ "username", "password" ]`)


### Compatible Strategies

* [omniauth-internal](https://github.com/jgraichen/omniauth-internal)
* [omniauth-kerberos](https://github.com/jgraichen/omniauth-kerberos)


## License

[MIT License](http://www.opensource.org/licenses/mit-license.php)

Copyright (c) 2012, Jan Graichen
