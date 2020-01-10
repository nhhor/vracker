# Application: **Vracker**
**A Ruby volunt33r_track3r**

##### By Noah Horwitz

###### _First published 2019-01-10_

## Description:
This application was made as part of a coding project for Noah Horwitz, a student at _[Epicodus](http://www.epicodus.com)_, which is a vocational school for technology careers based in Portland, OR. The project is designed to create an application to track volunteers working on projects using SQL for database queries. Each project should have many volunteers, but a volunteer can only work on one project at a time (a one-to-many relationship).

<!-- This project is fully deployed on **Heroku** [here](https://vracker.herokuapp.com/) -->

## Setup/Installation instructions:
* Click the `Clone or download` button and copy the link.
* Open your terminal application (assuming **GIT Scripts** and **node.js** (with NPM), **psql**, and **Ruby 2.5.1** have been installed on your system) and type `git clone (link)`.
* In the terminal using the `cd`... command, navigate to the newly created repository and run `bundle install`.
* Then in the terminal, run `app.rb`.


## Technologies Used
> `Ruby`
> * gem `sinatra`
> * gem `sinatra-contrib`
> * gem `pry`
> * gem `rspec`
> * gem `capybara`
> * gem `pg`
> * gem `rake`
>
> `SQL`
> * `psql`


## Known Bugs
* None

## Behavior Driven Development Specifications

|Spec|Input|Output|
|-|-|-|
||||

## References

## Support and contact details
Contact [example@sample.com](mailto:example@sample.com)

## License
_This This repository is copyright (C) 2019 by Noah Horwitz and licensed under the GNU General Public License v3.0 [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html)_.

## Notes
psql
CREATE DATABASE volunteer_tracker;
\c volunteer_tracker;
CREATE TABLE projects (id serial PRIMARY KEY, title varchar);
CREATE TABLE volunteers (id serial PRIMARY KEY, name varchar, project_id int);
CREATE DATABASE volunteer_tracker_test WITH TEMPLATE volunteer_tracker;
