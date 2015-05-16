class DefaultController < ApplicationController
  def contacts
    @categories = Category.all
    @contacts = Contact.first
  end
end