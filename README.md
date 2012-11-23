# kibali

Kibali is a simple replacement for ACL9, a role-based authentication gem.
Kibali is primarily oriented for functioning as a before\_filter role authentication 
scheme for Rails controllers.

## Basic concepts
Authentication is often called for on a controller-by-controller basis, restricting
actions to users who possess certain roles. Kibali (current version) assumes only one role
per user. Kibali requires a _current__user _method accessible at the controller level
and which returns a User object.

Kibali adds, to the User model, role accessor methods: has\_role?, has\_role!, get\_role

## Structure

* necessary models: user, roles, roles\_users (join table)
* necessary migrations (for kibali): roles, roles\_users (join table)

## Dependency requirements

* Rails 3.2 or higher

## Installation

Either install the gem manually:

```
  $ gem install
```

Or use bundler and place in your Gemfile

```
  gem 'kibali'
```

## Setup

### Defaults assumed

*User* is the subject model: 
indicate by inserting the following macro after the class definition:
```
    acts_as_authorization_subject
```

*Role* is the role model: 
indicate by inserting the following macro after the class definition:

```
   acts_as_authorization_role
```

Note: the gem allows these names to be changed, but I haven't built tests
for verifying that they work.

```
   class Role < ActiveRecord::Base
     acts_as_authorization_role
   end

   class User < ActiveRecord::Base
     acts_as_authorization_subject
   end
```

### Migrations required

The roles table must be created (sorry, no generator yet)
Some of the fields are legacy from acl9 and currently are not used.

```
  create_table "roles", :force => true do |t|
    t.string   "name",              :limit => 40
    t.string   "authorizable_type", :limit => 40
    t.string  "authorizable_id"
    t.boolean "system", :default=>false
    t.datetime "created_at"
    t.datetime "updated_at"
  end
```

and the join table

```
    create_table :roles_users, :id => false, :force => true do |t|
      t.column  :user_id, :integer
      t.column  :role_id, :integer
    end
      add_index :roles_users, :user_id
```
 

## Usage

At the head of every controller for which you wish to control user access,
you'll need to place an _access_control_ macro which is used to generate a 
before_filter for the authorization checks. In the testing, I had to place the
parameter in a seperate statement because syntax errors were encountered. That
might be due to the limited test structure used. I'll show both forms here.

Unauthorized access yields an exception: Kibali::AccessDenied .
Syntax errors in formulating the control parameters will also raise an exception: Kibali::SyntaxError .
You'll probably want to catch those exceptions and handle them gracefully, probably in your ApplicationController.

Notice that roles, limit_types, and controller actions are all expected to be symbols.

You have complete freedom to define roles to be whatever you want: except for the reserved words: :all, :anonymous.

The access limitation types are: 

* :allow, :to, :only -- control what access is allowed; all else will be denied
* :deny, :except -- control what is denied; all else will be permitted

The action list can be empty; in which case, for :allow, all actions are permitted; and for :deny, no actions are permitted.
If both limit_type and action_list are missing, then :allow => [] will be assumed.

```
class AnyController < ApplicationController

   access_control {
       :admin   => { :allow => [] },
       :manager => { :deny  => [ :delete, :edit ] },
       :member  => { :allow => [ :index, :show  ] }
   }
```
 
alternatively

```
class AnyController < ApplicationController

   control_parameters = {
       :admin   => { :allow => [] },
       :manager => { :deny  => [ :delete, :edit ] },
       :member  => { :allow => [ :index, :show  ] }
   }
   access_control control_parameters
```
 
Catch exceptions:

```
class ApplicationController < ActionController::Base
   rescue_from Kibali::AccessDenied do |e|
     # do something here
   end
```


## Examples

Please see the examples in the test folder
 
## Acknowledgements

Kibali was influenced by the acl9 gem (https://github.com/be9/acl9). 
I used acl9 for a number of years until it broke under Rails 3.2.x with a SystemStack error. 
Trying to fix the bug proved to be difficult due to the extent of meta programming. Noting that Rails now
had a simple way to designate a class to handle before_filters 
(Gavin Morrice's excellent tutorial: http://gavinmorrice.com/blog/posts/15-dryer-neater-rails-before_filters-using-classes),
I decided that a simpler role-based authorization Rails 3.2.x gem would be valuable. As I already had a production app based
on acl9, I wanted the conversion to be as seamless as possible. I've kept the same tables and naming. And I've made
the access_control syntax similar (though not the same). I did keep the same model macro names and config default variables,
but all access_control code has changed. The tests are all different.


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

