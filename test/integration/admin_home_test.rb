require 'test_helper'

feature 'Admin Home' do
  scenario 'See a list of posts' do
    visit '/admin'

    page.must_have_selector 'span', text: 'All posts'
  end

  scenario 'See 2 posts in posts list' do
    visit '/admin'

    within('#posts-list > ol') do
      page.all('li').count.must_equal 2
    end
  end

  scenario 'First post is selected' do
    visit '/admin'

    within('#posts-list > ol') do
      page.all('li.selected').count.must_equal 1
    end
  end

  scenario 'Body for selected post is displayed' do
    visit '/admin'

    within('#preview') do
      page.must_have_selector '#post-preview'
    end
  end

  scenario 'Post title is being show in preview for selected post' do
    visit '/admin'

    within('#post-preview > #wrapper') do
      page.must_have_selector 'h1', text: 'My very first post'
    end
  end

  scenario 'Post title and body is shown in preview when click in second post is list' do
    visit '/admin'
    page.find('#posts-list > ol > li:nth-child(2) > a').click

    within('#post-preview > #wrapper') do
      page.must_have_selector 'h1', text: 'My second post'
    end
  end

  scenario 'Click button to add new post' do
    visit '/admin'

    click_link '+'

    within('#editor') do
      page.must_have_selector '#post-title'
      page.must_have_selector '#post-editor'
      page.must_have_selector '#post-preview'
    end
  end
end
