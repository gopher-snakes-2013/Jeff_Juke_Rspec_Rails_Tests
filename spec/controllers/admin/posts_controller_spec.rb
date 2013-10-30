require 'spec_helper'

describe Admin::PostsController do
  let(:valid_attributes) {
   { title:"New title!", content:"lots of content" }
  }
  describe "admin panel" do
    it "#index" do
      get :index
      response.status.should eq 200
    end

    it "#new" do
      get :new
      response.status.should eq 200
    end

    context "#create" do
      it "creates a post with valid params" do
        expect {
        post :create, post: valid_attributes
        }.to change(Post, :count).by(1)
        expect(response).to be_redirect
      end

      it "doesn't create a post when params are invalid" do
        valid_attributes.delete(:content)
        expect {
          post :create, post: valid_attributes
        }.to_not change(Post, :count)
      end
    end

    let!(:article) {Post.create(valid_attributes)}
    context "#edit" do
      it "updates a post with valid params" do
        valid_attributes[:content] = "meow"
        put :update, :id =>article.id , post: valid_attributes
        response.status.should eq 302
      end
      it "doesn't update a post when params are invalid" do
        put :update, :id =>article.id , post:{:title => nil}
        response.status.should eq 200
      end
    end

    it "#destroy" do
      expect {
        delete :destroy, :id => article.id
      }.to change(Post, :count).by(-1)

    end
  end
end
