# ActionVersion

### Warning: This is currently a work in progress

ActionVersion provides a simple and elegant way of versionning REST APIs.

It's designed to simplify versioning APIs with the current date version string
like Foursquare's API but supports incremental versions as well.

## Installation

Add this line to your application's Gemfile:

    gem 'actionversion'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install actionversion

## Usage

ActionVersion let's you version controllers with a single action (named `perform`) 
so if you have a route like:

```ruby
get :profile, to 'profiles#perform'
```

You can version your `ProfilesController` like:

```ruby
class ProfilesController < ApplicationController
  include ActionVersion::Controller

  version(2) do
    render json: {
      name: "John Doe",
    }
  end

  version(3) do
    render json: {
      first_name: "John",
      last_name: "Doe"
    }
  end

end
```

Now you can query your new API endpoint using curl like:

```bash
$ curl -H 'Accept: application/json; version=2' http://localhost:3000/profile
{"name":"John Doe"}
$ curl -H 'Accept: application/json; version=3' http://localhost:3000/profile
{"first_name":"John","last_name":"Doe"}
```

And if you release a new version you don't have to do anything on your old
endpoints to "port them" because ActionVersion will return the latest available
definition

```bash
$ curl -H 'Accept: application/json; version=4' http://localhost:3000/profile
{"first_name":"John","last_name":"Doe"} # The same as version 3
```

And on the other side if you request a version with a lower number it will 
render a not foud error

```bash
$ curl -i -H 'Accept: application/json; version=1' http://localhost:3000/profile
HTTP/1.1 404 Not Found
...

```

For more use cases and examples [check out the wiki](https://github.com/sagmor/actionversion/wiki)

## Contributing

1. Fork it ( https://github.com/sagmor/actionversion/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
