Seed Damage Calculator
======

[![Coverage Status](https://coveralls.io/repos/github/iamliamnorton/seed-damage-calculator/badge.svg?branch=master)](https://coveralls.io/github/iamliamnorton/seed-damage-calculator?branch=master)

Calculation app used to find the [optimum fertilizer to seed ratio](http://seed-damage-calculator.herokuapp.com) for sowing with crops.

#### Development

Build the docker image with:

```
make build
```

The database is seeded with:

```
make db
```

This app can be run with docker/compose locally with:

```
make run
```

The tests are run with:

```
make test
```

#### Deploy

After changes have been merged to master and all tests are passing, deploy with:

```
make deploy
```
