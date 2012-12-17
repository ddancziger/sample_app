require 'spec_helper'

describe "UserPages" do
  subject{page}
  describe "Sign Up Page" do
    before {visit signup_path}

    it {should have_selector('h1', text: 'Sign Up')}
    it {should have_selector('title', text: full_title('Sign Up'))}
   end

   describe "profile page" do
        let(:user) {FactoryGirl.create(:user)}
        before {visit user_path(user)}

        it {should have_selector('h1', text: user.name)}
        it {should have_selector('title', text: user.name)}
   end

   describe "signup" do
    before { visit signup_path }
    let(:submit) {"Create my account"}

    describe "Informacion invalida" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
        
      end

      describe "despues de submit" do
        before{ click_button submit}
        it {should have_selector('title',text: 'Sign up')}
        it {should have_content('error')}
        it {should_not have_content('Password digest')}

      end

    end

    describe "Informacion valida" do
      
        before{
          fill_in "Name", with: "Example User"
          fill_in "Email", with: "user@example.com"
          fill_in "Password", with: "foobar"
          fill_in "Confirmation", with: "foobar"

        }
       it "should create a user" do 
         expect { click_button submit }.to change(User, :count).by(1)
       end
    end

    describe "despues de guardar el usuario" do

      before{ click_button submit}
      let(:user) {User.find_by_email("user@example.com")}

      it { should have_selector('title', text: user.name)}
      it { should have_selector('div.alert-success', text: 'Welcome')}

    end

   end

end
