require 'spec_helper'

describe "Static pages" do
 
    describe "Home Page" do
        it "should have the content 'Sample App'" do
            visit '/static_pages/home'
            page.should have_selector('h1', :text => 'Sample App')
        end

        it 'should have the right title' do
            visit '/static_pages/home'
            page.should have_selector('title', :text => "Ruby on Rails Tutoria Sample App | Home")
        end
    end

    describe "Help Page" do
        it "should have the content 'Help'" do
            visit '/static_pages/help'
            page.should have_selector('h1', :text => 'Help')
        end

        it 'should have the right title' do
            visit '/static_pages/help'
            page.should have_selector('title', :text => "Ruby on Rails Tutoria Sample App | Help")
        end
    end

    describe "Help Page" do
        it "should have the content 'About Us'" do
            visit '/static_pages/about'
            page.should have_selector('h1', :text => 'About Us')
        end

        it 'should have the right title' do
            visit '/static_pages/about'
            page.should have_selector('title', :text => "Ruby on Rails Tutoria Sample App | About")
        end
    end

    describe "Contact Page" do
        it "should have the h1 'Contact'" do
            visit '/static_pages/contact'
            page.should have_selector('h1', :text => 'Contact')
        end

        it 'should have the right title' do
            visit '/static_pages/contact'
            page.should have_selector('title', :text => "Ruby on Rails Tutoria Sample App | Contact")
        end
    end
end
