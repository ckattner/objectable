# Objectable

[![Gem Version](https://badge.fury.io/rb/objectable.svg)](https://badge.fury.io/rb/objectable) [![Build Status](https://travis-ci.org/bluemarblepayroll/objectable.svg?branch=master)](https://travis-ci.org/bluemarblepayroll/objectable) [![Maintainability](https://api.codeclimate.com/v1/badges/047c45ae0016941706e1/maintainability)](https://codeclimate.com/github/bluemarblepayroll/objectable/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/047c45ae0016941706e1/test_coverage)](https://codeclimate.com/github/bluemarblepayroll/objectable/test_coverage) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This library streamlines value setting and getting for any type of object.  It can give an object a hash-like interface without modifying/changing the underlying object's implementation.  It uses the following methodology:

* If the object is a hash and a string key exists then return the key's value.
* If the object is a hash and a symbol key exists then return the key's value.
* If the object publicly responds to the key then call key on the object.

This seems rather trivial but consider the following additional value propositions:

* It can handle dot-notation/key paths for nested objects.
* It can recursively traverse object graphs to set/get the desired value.  This can be used to build up deep object graphs.

See the `examples` section for more information.

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

Let's define a set of objects built using different constructs but all essentially represent the same graphs:

```ruby
class Employee < Struct.new(:id, :demographics); end
class Demographics < Struct.new(:first); end

symbol_based_hash = { id: 1, demographics: { first: 'Matt' } }
string_based_hash = { 'id' => 1, 'demographics' => { 'first' => 'Matt' } }
open_struct = OpenStruct.new(id: 1, demographics: OpenStruct.new(first: 'Matt'))
object = Employee.new(1, Demographics.new('Matt'))
```

### Getting Values

The following calls will all resolve to the same respective values:

```ruby
resolver = Objectable.resolver

# All resolve to the value of: 1
resolver.get(symbol_based_hash, :id)
resolver.get(symbol_based_hash, 'id')
resolver.get(string_based_hash, :id)
resolver.get(string_based_hash, 'id')
resolver.get(open_struct, :id)
resolver.get(open_struct, 'id')
resolver.get(object, :id)
resolver.get(object, 'id')

# All resolve to the value of: Matt
resolver.get(symbol_based_hash, :'demographics.first')
resolver.get(symbol_based_hash, 'demographics.first')
resolver.get(string_based_hash, :'demographics.first')
resolver.get(string_based_hash, 'demographics.first')
resolver.get(open_struct, :'demographics.first')
resolver.get(open_struct, 'demographics.first')
resolver.get(object, :'demographics.first')
resolver.get(object, 'demographics.first')
```

As you can see you do not have to worry about nested object traversal, dot-notation, or key type; this library gives you a unified interface when accessing values.

### Setting Values

Say we want to update a the `id` and `first` attributes from the objects:

```ruby
resolver = Objectable.resolver

# All calls will set the object's respective id attribute to: 999
resolver.set(symbol_based_hash, :id, 999)
resolver.set(symbol_based_hash, 'id', 999)
resolver.set(string_based_hash, :id, 999)
resolver.set(string_based_hash, 'id', 999)
resolver.set(open_struct, :id, 999)
resolver.set(open_struct, 'id', 999)
resolver.set(object, :id, 999
resolver.set(object, 'id', 999

# All calls will set the object's respective id attribute to: Nick
resolver.set(symbol_based_hash, :'demographics.first', 'Nick')
resolver.set(symbol_based_hash, 'demographics.first', 'Nick')
resolver.set(string_based_hash, :'demographics.first', 'Nick')
resolver.set(string_based_hash, 'demographics.first', 'Nick')
resolver.set(open_struct, :'demographics.first', 'Nick')
resolver.set(open_struct, 'demographics.first', 'Nick')
resolver.set(object, :'demographics.first', 'Nick')
resolver.set(object, 'demographics.first', 'Nick')
```

### Dot-Notation Customization

By default dot-notation is turned on and the path separator is set as a period.  You can disable or customize this by passing in a separator option into `resolver`:

```ruby
resolver_without_dot_notation     = Objectable.resolver(separator: nil)
resolver_with_custom_dot_notation = Objectable.resolver(separator: '$')
```

Also note that you can choose to pass in an array into the expression and it will be used for customized traversal but without using dot-notation.  The following are equivalent:

```ruby
Objectable.resolver.get([:demographics, :first], symbol_based_hash)
Objectable.resolver.get('demographics.first', symbol_based_hash)
```

### Gaps

When setting values of nested objects:

* If the parent object is null then the parent object will be initialized based on the preceding class.  This is not ideal for complex object graphs but works quite lovely for Hash and OpenStruct objects.  In the future this can be extended so the object type graph can be passed in and used as a blueprint for parent initialization.

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
