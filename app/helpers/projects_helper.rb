module ProjectsHelper
  def row_classes_for_project(project)
    if ['Won','Lost'].include? project.stage
      highlight_class = project.stage == 'Won' ? 'success' : 'danger'
      "class=\"#{highlight_class}\"".html_safe 
    else
      ''
    end
  end
end
