# Reviews Module 

Reviews module for e-commerce website of Front End Capstone Project #HRSF127

## Related Projects

  - https://github.com/9-space-lobster/addidas-product
  - https://github.com/9-space-lobster/adidas-related-info
  - https://github.com/9-space-lobster/adidas-instagram-feed
  - https://github.com/9-space-lobster/adidas-crawler

## Table of Contents

1. [Usage](#Usage)
1. [Requirements](#requirements)
1. [Development](#development)

## Usage

### Seeding the MySQL Database

```sh
cp db-mysql/config.example.js db-mysql/config.js
```
Make sure that the new config.js file is ignored by Git, then update `user` and `password` with your MySQL credentials. It is currently defaulted to `root` and ` `.

```sh
brew services list
brew services start mysql@5.7
```
Start your MySQL database. Your version may differ.

```sh
npm run seed
```
Your database is now seeded.

### Starting the Server

```sh
npm run react-dev
npm run server-dev
```

This will run the project with a seeded MySQL database on [localhost:3003](http://localhost:3003) 

## Requirements

An `nvmrc` file is included if using [nvm](https://github.com/creationix/nvm).

- Node 12.16.0
- npm 6.14.
- MySQL 5.7.0

```sh
node --version
npm --version
mysql --version && which mysql
```

## Development

### Installing Dependencies

From within the root directory:

```sh
npm install
```

- React 16
- Express 4
- Babel 7
- Webpack 4

### Install MySQL 5.7 on macOS
This procedure explains how to install [MySQL](https://www.mysql.com) using [Homebrew](http://brew.sh) on macOS (Sierra 10.12 and up)

https://gist.github.com/operatino/392614486ce4421063b9dece4dfe6c21
