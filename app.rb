require('sinatra')
require('sinatra/reloader')
require('./lib/project')
require('./lib/volunteer')
require('pry')
require('pg')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "volunteer_tracker"})

get('/') do
  # DB.exec('DELETE FROM volunteers *;')
  # DB.exec('DELETE FROM projects *;')
  @projects = Project.all
  # @volunteers = Volunteer.all
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

get('/project/new') do
  erb(:new_project)
end

get('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  # binding.pry
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

# patch('/projects/:id') do
#   # binding.pry
#   @project = Project.find(params[:id].to_i())
#   # values = *params.values
#
#   # project.update({:title => 'Teaching Ruby to Kids', :id => nil})
#
#   @project.update(params[:title])
#   @projects = Project.all
#   erb(:projects)
# end



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

get('/volunteer/new') do
  erb(:new_volunteer)
end

get('/projects/:id/volunteers/:volunteer_id') do
  @volunteer = Volunteer.find(params[:volunteer_id].to_i())
  # if @volunteer != nil
  #   erb(:volunteer)
  # else
  #   @project = Project.find(params[:id].to_i())
  #   erb(:project_error)
  # end
  erb(:volunteer)


# get ('/projects/:id/volunteers/:song_id') do
#   @song = Song.find(params[:song_id].to_i())
#   if @song != nil
#     erb(:song)
#   else
#     @album = Album.find(params[:id].to_i())
#     erb(:album_error)
#   end
#   # erb(:song)
# end


  # get ('/albums/:id') do
  #   @album = Album.find(params[:id].to_i())
  #   if @album != nil
  #     erb(:album)
  #   else
  #     erb(:album_error)
  #   end
  #   # erb(:album)
  # end




end

get('/volunteers/:id/edit') do
  @volunteers = Volunteer.find(params[:id].to_i())
  erb(:edit_volunteer)
end

# post('/projects/:id/volunteers') do
#   @name = params[:volunteer_name]
#   @project_id = params[:project_id]
#   volunteer = Volunteer.new({:name => @name, :project_id => 0, :id => nil})
#   # binding.pry
#   volunteer.save()
#   redirect to("/volunteers")
# end

post ('/projects/:id/volunteers') do
  @name = params[:volunteer_name]
  @project = Project.find(params[:id].to_i())
  volunteer = Volunteer.new({:name => params[:volunteer_name], :project_id => @project.id, :id => nil})
  volunteer.save()
  erb(:project)
end


post('/volunteers/:id') do
  if params[:book_name]
    name = params[:book_name]
    id = params[:id]
    # binding.pry
    @volunteers = Volunteer.find(params[:id].to_i())
    @volunteers.update({:book_name => name})
    redirect to("/volunteers/#{params[:id]}")
  elsif params[:book_id]
    @volunteers = Volunteer.find(params[:id].to_i())
    @volunteers.return_book(params[:book_id].to_i)
    redirect to("/volunteers/#{params[:id]}")
  end

end

patch('/volunteers/:id') do
  @volunteers = Volunteer.find(params[:id].to_i())
  @volunteers.update(params[:name])
  redirect to("/volunteers/#{params[:id]}")
end

delete('/volunteers/:id') do
  @volunteers = Volunteer.find(params[:id].to_i())
  @volunteers.delete()
  redirect to('/volunteers')
end
