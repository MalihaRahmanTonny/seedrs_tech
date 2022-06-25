# Seedrs Tech Test Project

#### Table of Contents
* [Introduction](#introduction)
* [Project Setup](#project-setup)
    * [Installation](#installation)
    * [Database Setup](#database-setup)
    * [Run Server](#run-server)
    * [Using Docker](#docker)
* [Rspec](#rspec)
* [APIs](#api)

<a name="introduction"></a>
## Introduction

This project is build based on Seedrs tech test requirements, where only
required APIs are build along with necessary model structures.

<a name="project-setup"></a>
## Project Setup

<a name="installation"></a>
### Installation

* Clone repository
```bash
SSH: git@github.com:MalihaRahmanTonny/seedrs_tech.git
HTTPS: https://github.com/MalihaRahmanTonny/seedrs_tech.git
```
* Navigate into the project's directory
```bash
$ cd seedrs_tech
```

#### Install Backend Library Dependencies
```bash
$ bundle install
```

<a name="database-setup"></a>
#### Database Setup

```bash
$ cp config/database.example.yml config/database.yml

$ bundle exec rake db:create
$ bundle exec rake db:migrate
$ bundle exec rake db:seed
````

<a name="run-server"></a>
#### Run Server

* Using rails command. Service will run in `localhost:3000`
```bash
$ bundle exec rails s
```

<a name="docker"></a>
## Using Docker
```bash
$ cp config/database.docker.yml config/database.yml
$ docker compose up --build
$ docker compose run web rake db:create db:migrate db:seed
```

<a name="rspec"></a>
## Rspec

* This application is currently using rspec for testing.
```bash
$ bundle exec rspec
```

<a name="api"></a>
## APIs

* Campaign API
  * GET #index: 
    * `api/v1/campaigns`
    * Filter Params:
      * name
      * sector
      * country
      * target_amount
      * investment_multiple
      * investor_number
  * GET #show: `api/v1/campaigns/:id`
  * POST #create: `api/v1/campaigns`
  * PUT #update: `api/v1/campaigns/:id`
  * DELETE #destroy: `api/v1/campaigns/:id`

* Investment API
  * GET #index: 
    * `api/v1/campaigns/:id/investments`
    * `api/v1/investments`
  * GET #show: `api/v1/campaigns/:campaign_id/investments/:id`
  * POST #create: `api/v1/investments`
  * PUT #update: `api/v1/campaigns/:campaign_id/investments/:id`
  * DELETE #destroy: `api/v1/campaigns/:campaign_id/investments/:id`

Mentioned APIS are implemented and to test the endpoints Postman's 
embedded static link is provided.

* Instruction for using the embedded link
  * Click `Run in Postman`
  * Open with web or app version
  * The collection will be imported
  * All endpoints examples are given. But the local server must be running to test these endpoints.

[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/b23f2e4198913d14cf43?action=collection%2Fimport)