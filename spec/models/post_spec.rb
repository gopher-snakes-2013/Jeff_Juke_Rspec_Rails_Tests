require 'spec_helper'

describe Post do
  let(:post) {
    post = Post.new
    post.title   = "New post!"
    post.content = "A great story"
    post
   }
  it "title should be automatically titleized before save" do
     post.title.should eql("New post!")
    expect {
      post.save
    }.to change(post, :title).to("New Post!")
  end

  it "post should be unpublished by default" do
    post.save
    expect(post.is_published).to  be_false
  end

  # a slug is an automaticaly generated url-friendly
  # version of the title
  it "slug should be automatically generated" do
    post.slug.should be_nil
    expect {
      post.save
    }.to change(post, :slug).to("new-post")
  end
end
