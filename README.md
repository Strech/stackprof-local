# [stackprof](https://github.com/tmm1/stackprof)-local

This gem inpired by two awesome gems:
[stackprof](https://github.com/tmm1/stackprof) & [stackprof-remote](https://github.com/quirkey/stackprof-remote).

Unfortunately it's not always comfortable to read dumps on production machine.
And you want to copy dump on your local machine and read'em carefully in quiet place.

So, what happend if you do so? Something like this:

```bash
$ stackprof --method Middleware::Runner#call tmp/stackprof/stackprof-wall-14962-1412161559.dump
Middleware::Runner#call (/home/user/project/shared/bundle/ruby/2.1.0/gems/middleware-0.1.0/lib/middleware/runner.rb:27)
  samples:     0 self (0.0%)  /   6123 total (70.7%)
  callers:
    6123  (  100.0%)  Middleware::Builder#call
  callees (6123 total):
    6089  (   99.4%)  ThinkingSphinx::Middlewares::StaleIdFilter#call
      34  (    0.6%)  ThinkingSphinx::Middlewares::SphinxQL#call
  code:
/Users/me/.rbenv/versions/2.1.2/lib/ruby/gems/2.1.0/gems/stackprof-0.2.7/lib/stackprof/report.rb:347:in `readlines':
No such file or directory @ rb_sysopen - /home/user/project/shared/bundle/ruby/2.1.0/gems/middleware-0.1.0/lib/middleware/runner.rb (Errno::ENOENT)
	from /Users/me/.rbenv/versions/2.1.2/lib/ruby/gems/2.1.0/gems/stackprof-0.2.7/lib/stackprof/report.rb:347:in `source_display'
	from /Users/me/.rbenv/versions/2.1.2/lib/ruby/gems/2.1.0/gems/stackprof-0.2.7/lib/stackprof/report.rb:265:in `block in print_method'
	from /Users/me/.rbenv/versions/2.1.2/lib/ruby/gems/2.1.0/gems/stackprof-0.2.7/lib/stackprof/report.rb:238:in `each'
	from /Users/me/.rbenv/versions/2.1.2/lib/ruby/gems/2.1.0/gems/stackprof-0.2.7/lib/stackprof/report.rb:238:in `print_method'
	from /Users/me/.rbenv/versions/2.1.2/lib/ruby/gems/2.1.0/gems/stackprof-0.2.7/bin/stackprof:62:in `<top (required)>'
	from /Users/me/.rbenv/versions/2.1.2/bin/stackprof:23:in `load'
	from /Users/me/.rbenv/versions/2.1.2/bin/stackprof:23:in `<main>'
```

Because dump was made on another machine with another gems path and project path.

## Usage

Project specific configuration options stored in project root folder in `.stackprof-local` file,
and it's looks like `.rspec` configuration file

```
$ cat /path/to/project/.stackprof-local
--remote-gems /home/user/project/shared/bundle/ruby/2.1.0/gems
--remote-project /home/user/project/releases/20141001101534
--local-gems /Users/me/.rbenv/versions/2.1.2/lib/ruby/gems/2.1.0/gems
--local-project /Users/me/Development/project
```

stackprof-local provides an interactive pry-based [cli-utility](https://github.com/quirkey/stackprof-remote#cli)
taken from stackprof-remote

```
$ stackprof-local-cli tmp/stackprof/stackprof-wall-14962-1412161559.dump
stackprof> method Middleware::Runner#call
Middleware::Runner#call (/home/user/project/shared/bundle/ruby/2.1.0/gems/middleware-0.1.0/lib/middleware/runner.rb:27)
  samples:     0 self (0.0%)  /   6123 total (70.7%)
  callers:
    6123  (  100.0%)  Middleware::Builder#call
  callees (6123 total):
    6089  (   99.4%)  ThinkingSphinx::Middlewares::StaleIdFilter#call
      34  (    0.6%)  ThinkingSphinx::Middlewares::SphinxQL#call
  code:
            |     1  | module Middleware
            |     2  |   # This is a basic runner for middleware stacks. This runner does
            |     3  |   # the default expected behavior of running the middleware stacks
            |     4  |   # in order, then reversing the order.
            |     5  |   class Runner
            |     6  |     # A middleware which does nothing
            |     7  |     EMPTY_MIDDLEWARE = lambda { |env| }
            |     8  |
            |     9  |     # Build a new middleware runner with the given middleware
            |    10  |     # stack.
  ...
```

All of configuration options are available as cli arguments and will override file defined options

```
$ stackprof-local-cli --remote-gems '/path/to/gems' tmp/stackprof/stackprof-wall-14962-1412161559.dump
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'stackprof-local'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install stackprof-local

## Contributing

1. Fork it ( https://github.com/Strech/stackprof-local/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
