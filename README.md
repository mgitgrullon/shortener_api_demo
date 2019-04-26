# URL shortener API demo

### Overview
The solution consists of:

1. A based36, 6 characters long generated hash for the shortened link.
2. An activerecord model for storing the details of the shortened link including the counter to store the link visit frequency.
3. A controller to redirect the user to the particular link, when they click on the shortened url. This controller will get a sanitized link from the database.

### Requirements:
```
ruby 2.4.2
Rails 5.2.3
```

### Setup the local env

Bring up the rails api
```
bundle install
rails db:migrate
```