class DefaultController < ApplicationController
  def contacts
    @categories = Category.all
  end
end