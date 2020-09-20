class ApplicationController < ActionController::Base
  def visit_this(link)
    link.update(quantity_visit: @link.quantity_visit + 1)
  end
end
