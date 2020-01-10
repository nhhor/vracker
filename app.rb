require('sinatra')
require('sinatra/reloader')
require('./lib/project')
require('./lib/volunteer')
require('pry')
require ('pg')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "volunteer_tracker"})

get('/') do
  @projects = Project.all
  @volunteer = Volunteer.all
  erb(:projects)
end

# PROJECT ROUTES

get ('/projects') do
  if params["search"]
    @projects = Project.search(params[:search])
  elsif params["sort"]
    @projects = Project.sort()
  else
    @projects = Project.all
  end
  erb(:projects)
end

get('/projects/new') do
  erb(:new_project)
end

get('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  erb(:project)
end

post('/projects') do
  name = params[:project_name]
  project = Project.new(name, nil, nil, nil, nil)
  project.save()
  @projects = Project.all() # Adding this line will fix the error.
  erb(:projects)
end

get('/projects/:id/edit') do
  @project = Project.find(params[:id].to_i())
  erb(:edit_project)
end

patch('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  values = *params.values
  @project.update(values[1], values[2], values[3], values[4])
  @projects = Project.all
  erb(:projects)
end

delete('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  @project.delete()
  @projects = Project.all
  erb(:projects)
end

# VOLUNTEER ROUTES

get('/volunteers') do
  if params["search"]
    @volunteer = Volunteer.search(params[:search])
  elsif params["sort"]
    @volunteer = Volunteer.sort()
  else
    @volunteer = Volunteer.all
  end
  erb(:volunteers)
end

get ('/volunteers/:id') do
  @volunteer = Volunteer.find(params[:id].to_i())
  if @volunteer != nil
    erb(:volunteer)

  else
    erb(:book_error)
  end
end

get ('/volunteers/:id/edit') do
  @volunteer = Volunteer.find(params[:id].to_i())
  erb(:edit_volunteer)
end

get ('/volunteer/new') do
  erb(:new_volunteer)
end

post ('/volunteers') do
  name = params[:volunteer_name]
  @volunteer = Volunteer.new({:name => name, :id => nil})
  @volunteer.save()
  redirect to('/volunteers')
end

post ('/volunteers/:id') do
  if params[:book_name]
    name = params[:book_name]
    id = params[:id]
    # binding.pry
    @volunteer = Volunteer.find(params[:id].to_i())
    @volunteer.update({:book_name => name})
    redirect to("/volunteers/#{params[:id]}")
  elsif params[:book_id]
    @volunteer = Volunteer.find(params[:id].to_i())
    @volunteer.return_book(params[:book_id].to_i)
    redirect to("/volunteers/#{params[:id]}")
  end

end

patch ('/volunteers/:id') do
  @volunteer = Volunteer.find(params[:id].to_i())
  @volunteer.update(params[:name])
  redirect to("/volunteers/#{params[:id]}")
end

delete ('/volunteers/:id') do
  @volunteer = Volunteer.find(params[:id].to_i())
  @volunteer.delete()
  redirect to('/volunteers')
end
