require 'rails_helper'
require 'sign_up_helper'
require 'create_video_helper'

RSpec.feature "video features", type: :feature do
  scenario "user can delete a video" do
    create_user_and_sign_up
    create_video
    visit "/videos"
    click_link "Destroy"
    expect(page).to have_content "Video was successfully destroyed."
  end

  scenario "User can't delete another users videos" do
    create_user_and_sign_up
    create_video
    visit "/videos"
    click_link "Sign out"
    create_user_and_sign_up_2
    expect(page).to have_no_link "Destroy"
  end

  scenario "A user can edit their video" do
    create_user_and_sign_up
    create_video
    visit "/videos"
    click_link "Edit"
    expect(page).to have_content "Editing Video"
  end

  scenario "A user can't edit someone elses video" do
    create_user_and_sign_up
    create_video
    visit "/videos"
    click_link "Sign out"
    create_user_and_sign_up_2
    expect(page).to have_no_link "Edit"
  end

  scenario "A user can search for a video" do
    create_user_and_sign_up
    create_video
    visit "/videos"
    fill_in("Search", with: "random")
    click_button "Search"
    expect(page).to have_content "random"
  end

  scenario "A user can comment on a video" do
    create_user_and_sign_up
    create_video
    fill_in 'comment_content', :with => 'great vid'
    click_button 'Create Comment'
    visit '/videos'
    click_link 'Show'
    expect(page).to have_content 'great vid'
  end
end