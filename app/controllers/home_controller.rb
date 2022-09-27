class HomeController < ApplicationController
    before_action :authenticate_user!
    
    def index
        @warehouse = Warehouse.all
    end
end
