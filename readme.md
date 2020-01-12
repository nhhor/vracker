# Application: **Vracker**
**A Ruby volunteer tracker**

##### By Noah Horwitz

###### _First published 2019-01-10_

## Description:
This application was made as part of a coding project for Noah Horwitz, a student at _[Epicodus](http://www.epicodus.com)_, which is a vocational school for technology careers based in Portland, OR. The project is designed to create an application to track volunteers working on projects using SQL for database queries. Each project should have many volunteers, but a volunteer can only work on one project at a time (a one-to-many relationship).

<!-- This project is fully deployed on **Heroku** [here](https://vracker.herokuapp.com/) -->

## Setup/Installation instructions:
* Click the `Clone or download` button and copy the link.
* Open your terminal application (assuming **GIT Scripts** and **node.js** (with NPM), **psql**, and **Ruby 2.5.1** have been installed on your system) and type `git clone (link)`.
* In the terminal using the `cd`... command, navigate to the newly created repository and run `bundle install`.
* In the terminal type `rake create[volunteer_tracker]`
* Next, in the terminal, run `app.rb`.
* Finally, in a browser navigate to `localhost:4567/`

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

## User Stories
* As a non-profit employee, I want to view, add, update and delete projects.
* As a non-profit employee, I want to view and add volunteers.
* As a non-profit employee, I want to add volunteers to a project.

## Behavior Driven Development Specifications
|Spec|Input|Output|
|-|-|-|
|User should be able to **C**reate new projects in the app and it will display (**R**ead) all projects entered.|Fill_in Project name: `Project1`, click_on `Create Project`|Project1|
|User should be able to **U**pdate existing project(s).|click_on `Project1`, fill_in Rename project: `project_A`, click_on `Update Project`| ProjectA|
|User should be able to **D**elete existing project(s).|... click_on `Delete Project`| _There are currently no records to display._|
||||
|User should be able to click on a created project and in the resulting view be able to **C**reate a new volunteer for that project and it will display (**R**ead) all volunteers entered.|... click_on `Project2`, fill_in `Volunteer1`, click_on `Add volunteer` |Project Name: _Project2_, Project volunteers: _Volunteer1_|
|User should be able to click on a created volunteer and add in the resulting view be able to **U**pdate the volunteer.|... click_on `Volunteer1`, fill_in `VolunteerA`, click_on `Update volunteer` |Project Name: Project2, Project volunteers: _VolunteerA_|
|User should be able to click on a created volunteer and add in the resulting view be able to **D**elete the volunteer.|... click_on `VolunteerA`, click_on `Delete volunteer` |Current volunteers _[none]_|
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
