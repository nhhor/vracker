class Project
  attr_reader :id
  attr_accessor :title

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end

  def save
    result = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(project_to_compare)
    self.title() == project_to_compare.title()
  end

  def self.all
    returned_projects = DB.exec("SELECT * FROM projects;")
    projects = []
    returned_projects.each() do |project|
      title = project.fetch("title")
      id = project.fetch("id").to_i
      projects.push(Project.new({:title => title, :id => id}))
    end
    projects
  end

# ORIG
  def self.find(id)
    @project = DB.exec("SELECT * FROM projects WHERE id = #{id};").first
    title = @project.fetch("title")
    id = @project.fetch("id").to_i
    Project.new({:title => title, :id => id})
  end


# NEW???
  # def self.find(id)
  #   project = DB.exec("SELECT * FROM projects WHERE id = #{id};").first
  #   # binding.pry
  #   if project
  #     title = project.fetch("title")
  #     id = project.fetch("id").to_i
  #     Project.new({:title => title, :id => id})
  #   else
  #     nil
  #   end
  # end






  def volunteers
    volunteers = DB.exec("SELECT * FROM volunteers WHERE project_id = #{@id};")
    volunteers.map do |element|
      Volunteer.find(element.fetch('id'))
    end
  end

  def update(title)
    # binding.pry
    @title = title.fetch(:title)
    DB.exec("UPDATE projects SET title = '#{@title}' WHERE id = #{@id};")

  end

  def update(attributes)
    if (attributes.is_a? String)
      @title = attributes
      DB.exec("UPDATE projects SET title = '#{@title}' WHERE id = #{@id};")
    else
  @title = title.fetch(:title)
  DB.exec("UPDATE projects SET title = '#{@title}' WHERE id = #{@id};")
    end
  end



  def delete
    DB.exec("DELETE FROM projects WHERE id = #{@id};")
  end

end
