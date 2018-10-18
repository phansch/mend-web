# mend-web

## Setup

All dependencies should be set up after running:

```console
bin/setup
```

This is only tested on Ubuntu Linux, may not work on MacOSX and will not work on
Windows.

To confirm that everying is working:

```console
rake test test:system
```

To start the server locally:

```console
rails s -p 3000
```

## RIIR

I would **like** this to be written in Rust, but the ecosystem is just not there
yet to develop this as fast as in ROR. I managed to set up a basic *working*
version in about 4 hours. I don't do Rails apps from scratch very often.
