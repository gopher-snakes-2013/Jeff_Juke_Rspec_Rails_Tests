require 'spec_helper'

feature 'Admin panel', :js => true do
  let(:attributes) {
    {
      :title => "New post!",
      :content => "A great story"
    }
  }
  let!(:post) { Post.create attributes }

  context "on admin homepage" do
    it "can see a list of recent posts" do
      visit admin_posts_path
      expect(page).to have_content "New Post!"
    end

    it "can edit a post by clicking the edit link next to a post" do
      visit admin_posts_path
      click_on("Edit")
      expect(page).to have_content "A great story"
      expect(page).to have_content "Publish?"
    end

    it "can delete a post by clicking the delete link next to a post" do
      visit admin_posts_path
      expect {
        click_on("Delete")
        page.driver.browser.switch_to.alert.accept
        sleep(1)
      }.to change(Post, :count).by(-1)
    end

    it "can create a new post and view it" do
       visit new_admin_post_path
       expect {
         fill_in 'post_title',   with: "Hello world!"
         fill_in 'post_content', with: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat."
         page.check('post_is_published')
         click_button "Save"

       }.to change(Post, :count).by(1)

       page.should have_content "Published: true"
       page.should have_content "Post was successfully saved."
     end
  end

  context "editing post" do
    it "can mark an existing post as unpublished" do
      visit edit_admin_post_path(post)

      page.should have_content "Published: false"
    end
  end

  context "on post show page" do
    it "can visit a post show page by clicking the title" do
      visit admin_posts_path
      click_on("New Post!")
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.content)
    end

    it "can see an edit link that takes you to the edit post path" do
      visit admin_post_path(post)
      click_on("Edit post")
      expect(page).to have_content "A great story"
      expect(page).to have_content "Publish?"

    end

    it "can go to the admin homepage by clicking the Admin welcome page link" do
      visit admin_post_path(post)
      click_on("Admin welcome page")
      expect(page).to have_content("Welcome to the admin panel!")
    end
  end
end
