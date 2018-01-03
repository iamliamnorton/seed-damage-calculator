Seed Damage Calculator
======

[![Circle CI](https://circleci.com/gh/iamliamnorton/seed-damage-calculator.png?style=shield&circle-token=b657e8a80560d44eef279665d59d9393bf8d54eb)](https://circleci.com/gh/iamliamnorton/seed-damage-calculator)
[![Coverage Status](https://coveralls.io/repos/github/iamliamnorton/seed-damage-calculator/badge.svg?branch=master)](https://coveralls.io/github/iamliamnorton/seed-damage-calculator?branch=master)

Calculation app used to find the [optimum fertilizer to seed ratio](http://seed-damage-calculator.herokuapp.com) for sowing with crops.

#### Development

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
