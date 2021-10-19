# README

### Overview

- No business logic in controllers / models / views
- Decent test coverage
- Component-based frontend design
- ESLint, StyleLint, Rubocop via git hooks
- Real-time comments & reactions updates via websocket


### Setup

The setup is pretty straightforward. Just run the database via docker-compose, install all dependencies and then run webpack and rails server via Procfile (e.g. using foreman).
db:setup script will prepare the data for you.

```
docker-compose up mysql

yarn
bundle
rails db:setup

foreman start
```

2 users are available:

```
email: 'test1@mail.com', password: '123123'
email: 'test2@mail.com', password: '123123'
```


### Possible improvements

- Add integration tests (e.g. using Cypress) to check all real-time communication works as expected. It's a bit tricky to test all of the JS code inside the Rails app
- Implement caching using a 3rd party storage (e.g. redis) instead of using in-memory storage
