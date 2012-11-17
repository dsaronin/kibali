# kibali

Kibali is a simple replacement for ACL9, a role-based authentication system.
Kibali is primarily oriented for functioning as a before_filter role authentication 
scheme for Rails controllers.

## Basic concepts

## Structure

* necessary models: user, roles (join table)
* necessary migrations: user, roles, roles_users (join table)

## Dependency requirements

* Rails 3.2 or higher

## Installation

Either install the gem manually:

```
  $ gem install
## Contributing to kibali
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2012 Daudi Amani. See LICENSE.txt for further details.

