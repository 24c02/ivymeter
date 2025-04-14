# IVyMeTeR

a lil' gem for handling USPS IV-MTR event data

mainly focused on piece data bc i don't really do capital-C Commercial mail, but the other stuff might should work too?

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add ivymeter
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install ivymeter
```

## Usage

```ruby
IvyMeter::Event::{Container,Tray,Bundle,Piece}Event
  .from_json(<hash from USPS webhook>) or
  .from_csv(<hash from USPS delimited file>)
```

## Development

`bundle exec exe/generate_operation_codes <xlsx>` whenever they come out with a new [opcode list](https://postalpro.usps.com/informedvisibility/OperationCodesList)

modify the `prop` statements in the event classes when a new version of the [external data dictionary](https://postalpro.usps.com/node/6307) is released
## Contributing

pull requests welcome! bug reports less welcome...

this project is housed on GitHub at [24c02/ivymeter](https://github.com/24c02/ivymeter).