# Objectable

[![Gem Version](https://badge.fury.io/rb/objectable.svg)](https://badge.fury.io/rb/objectable) [![Build Status](https://travis-ci.org/bluemarblepayroll/objectable.svg?branch=master)](https://travis-ci.org/bluemarblepayroll/objectable) [![Maintainability](https://api.codeclimate.com/v1/badges/047c45ae0016941706e1/maintainability)](https://codeclimate.com/github/bluemarblepayroll/objectable/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/047c45ae0016941706e1/test_coverage)](https://codeclimate.com/github/bluemarblepayroll/objectable/test_coverage) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

TODO.

## Installation

To install through Rubygems:

````
gem install install objectable
````

You can also add this to your Gemfile:

````
bundle add objectable
````

## Examples

TODO.

## Contributing

### Development Environment Configuration

Basic steps to take to get this repository compiling:

1. Install [Ruby](https://www.ruby-lang.org/en/documentation/installation) (check objectable.gemspec for versions supported)
2. Install bundler (gem install bundler)
3. Clone the repository (git clone git@github.com:bluemarblepayroll/objectable.git)
4. Navigate to the root folder (cd objectable)
5. Install dependencies (bundle)

### Running Tests

To execute the test suite run:

````
bundle exec rspec spec --format documentation
````

Alternatively, you can have Guard watch for changes:

````
bundle exec guard
````

Also, do not forget to run Rubocop:

````
bundle exec rubocop
````

### Publishing

Note: ensure you have proper authorization before trying to publish new versions.

After code changes have successfully gone through the Pull Request review process then the following steps should be followed for publishing new versions:

1. Merge Pull Request into master
2. Update ```lib/objectable/version.rb``` using [semantic versioning](https://semver.org)
3. Install dependencies: ```bundle```
4. Update ```CHANGELOG.md``` with release notes
5. Commit & push master to remote and ensure CI builds master successfully
6. Run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Code of Conduct

Everyone interacting in this codebase, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/bluemarblepayroll/objectable/blob/master/CODE_OF_CONDUCT.md).

## License

This project is MIT Licensed.
