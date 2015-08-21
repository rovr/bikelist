class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :load_types, :load_brands

  private

  def load_types
    @types = Type.all
  end

  def load_brands
    @brands ||= Brand.all
  end
end
