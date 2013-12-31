module Admin
  class DashboardController < ApplicationController
    layout 'admin'

    self.responder = JsonResponder
    include Restful::Base

    respond_to :html, only: [ :index, :new, :edit ]
    respond_to :json, only: [ :show, :create, :update ]

    restful model: :post, route_prefix: 'admin',
      actions: [ :index, :show, :new, :create, :edit, :update ]

    def index
      @posts = Post.order('id desc')

      index!
    end

    def create
      @post = Post.new secure_params

      if @post.save
        @post.resource_url = edit_resource_path(@post)
      end

      create!
    end

    private
    def secure_params
      params.require(:post).permit :title, :body, :title_slug, :published, :status, :tags
    end
  end
end
