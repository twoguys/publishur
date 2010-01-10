class WelcomeController < ApplicationController
  before_filter {|c| c.nav :home }

  def index
  end
end
