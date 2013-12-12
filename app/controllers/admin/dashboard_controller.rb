module Admin
  class DashboardController < ApplicationController
    layout 'admin'

    respond_to :html, only: [ :index, :new ]
    respond_to :json, only: [ :show ]

    include Restful::Base

    restful model: :post, actions: [ :index, :show, :new ]

    def index
      @posts = Post.order('id desc')

      index!
    end
  end
end
