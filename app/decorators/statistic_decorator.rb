class StatisticDecorator < Drape::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def section
    object.section.name
  end

  def product
    object.product&.name
  end

  # def department
  #   object.department.name
  # end

end
