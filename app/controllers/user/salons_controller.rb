class User::SalonsController < ApplicationController
  def index
    @salons = Salon.all
  end
end
