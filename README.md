# kitlog [![CircleCI](https://circleci.com/gh/lawrencejones/kitlog.svg?style=svg)](https://circleci.com/gh/lawrencejones/kitlog)

The smallest of logging libraries that imitates the go-kit logger interface.
Super simple, just:

```ruby
irb(main):001:0> require "kitlog"

irb(main):002:0> Kitlog.log(event: "hello, from a terminal")
event="hello, from a terminal" ts="2019-12-16T11:23:07.908104000Z" tid=70217581666320

irb(main):003:0> Kitlog.configure(format: :json)
irb(main):004:0> Kitlog.log(event: "hello, with json")
{"event":"hello, with json","ts":"2019-12-16T11:23:27.448655000Z","tid":70217581666320}

irb(main):005:0> logger = Kitlog.with(component: "app");
irb(main):006:0> logger.log(event: "ping")
{"component":"app","event":"ping","ts":"2019-12-16T11:23:46.460129000Z","tid":70217581666320}
```
