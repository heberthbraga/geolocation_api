module Renderer
  extend ActiveSupport::Concern
  
  def render_json(serializer, entity)
    render json: serializer.new(entity).to_h
  end
end