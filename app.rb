require('sinatra')
require('sinatra/reloader')
require('./lib/project')
require('./lib/volunteer')
require('pry')
require('pg')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "volunteer_tracker"})


# PROJECT ROUTES


get('/') do
  @projects = Project.all
  erb(:projects)
end

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

get('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  erb(:project)
end

post('/projects') do
  name = params[:project_title]
  project = Project.new({:title => name, :id => nil})
  project.save()
  @projects = Project.all()
  erb(:projects)
end

get('/projects/:id/edit') do
  @project = Project.find(params[:id].to_i())
  erb(:edit_project)
end

patch ('/projects/:id') do
    @project = Project.find(params[:id].to_i())
  @project.update(params[:title])
  redirect to("/projects/#{params[:id]}")
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
    @volunteers = Volunteer.search(params[:search])
  elsif params["sort"]
    @volunteers = Volunteer.sort()
  else
    @volunteers = Volunteer.all
  end
  erb(:volunteers)
end

get('/projects/:id/volunteers/:volunteer_id') do
  @volunteer = Volunteer.find(params[:volunteer_id].to_i())
  if @volunteer != nil
    erb(:volunteer)
  else
    @project = Project.find(params[:id].to_i())
    erb(:project_error)
  end
end

post ('/projects/:id/volunteers') do
  @name = params[:volunteer_name]
  @project = Project.find(params[:id].to_i())
  volunteer = Volunteer.new({:name => params[:volunteer_name], :project_id => @project.id, :id => nil})
  volunteer.save()
  erb(:project)
end

patch('/projects/:id/volunteers/:volunteer_id') do
  @project = Project.find(params[:id].to_i())
  @volunteer = Volunteer.find(params[:volunteer_id].to_i())
  @volunteer.update(params[:name], @project.id)
  redirect to("/projects/#{params[:id]}/volunteers/#{params[:volunteer_id]}")
end

delete('/projects/:id/volunteers/:volunteer_id') do
  @volunteers = Volunteer.find(params[:volunteer_id].to_i())
  @volunteers.delete()
  redirect to('/projects')
end
