module ApplicationHelper
  def model_name(name = '')
    t(name, scope: 'activerecord.models')
  end
end
