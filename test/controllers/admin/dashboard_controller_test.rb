require 'test_helper'

describe Admin::DashboardController do
  context 'GET index' do
    it 'load posts list and selected post' do
      get :index

      assigns[:posts].wont_be_nil

      must_respond_with :success
      must_render_template :index
    end
  end

  context 'XHR show' do
    it 'loads a single post and return json' do
      post = posts(:one)
      xhr :get, :show, id: post.id

      must_respond_with :success

      resource = JSON.parse response.body
      resource['title'].must_equal 'My very first post'
    end
  end
end
