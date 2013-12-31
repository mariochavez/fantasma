require 'test_helper'

describe Post do
  subject { Post.new }

  context 'custom attributes' do
    it 'serialize tags on read' do
      subject.tags = %w(tag1 tag2)

      subject.text_tags.must_equal 'tag1, tag2'
    end

    it 'convert tags to an array on write' do
      subject.text_tags = 'tag2, tag3, tag2'

      subject.tags.must_equal %w(tag2 tag3)
    end

    it 'reads current slug' do
      title = 'sample-post'
      subject.slug = title

      subject.title_slug.must_equal title
    end

    it 'update slug if different' do
      title = 'sample-post'
      subject.slug = title

      update_title = "#{title}-1"
      subject.title_slug = update_title

      subject.slug.must_equal update_title
    end

    it 'does not update slug if title_slug empty' do
      title = 'sample-post'
      subject.slug = title

      subject.title_slug = ''

      subject.slug.must_equal title
    end
  end
end
