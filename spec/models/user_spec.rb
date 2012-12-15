require 'spec_helper'

describe User do
  
    before { @user = User.new(name: 'Daniel Dancziger', email:'ddancziger@gmail.com',
                            password: "foobar", password_confirmation: "foobar")}
    subject {@user}

    it {should respond_to(:name)}
    it {should respond_to(:email)}
    it {should respond_to(:password_digest)}
    it {should respond_to(:password)}
    it {should respond_to(:password_confirmation)}
    it {should respond_to(:authenticate)}

    it {should be_valid}

    describe 'No tiene Nomber' do
        before { @user.name = " "}
        it {should_not be_valid}
    end

    describe 'Email No en Blanco' do
        before {@user.email = " "}
        it{should_not be_valid}
    end

    describe "Nomber demasiado largo" do
        before {@user.name = 'a'*51}
        it{should_not be_valid}
    end

    describe "Formato Email Invalido" do
        it "Tiene que ser invalido" do
            addresses = %w[user@foo,com user_at_foo.org example@foo.]
            addresses.each do |invalid_address|
                @user.email = invalid_address
                @user.should_not be_valid
            end
        end
    end

    describe 'Email formato valido' do
        it 'deberia tener este formato' do
            addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.com]
            addresses.each do |invalid_address|
                @user.email = invalid_address
                @user.should be_valid
            end
        end
    end

    describe 'Email ya tomado' do
        before do
            user_with_same = @user.dup
            user_with_same.save
        end

        it {should_not be_valid}
    end

    describe 'Password no presente' do
        before{ @user.password = @user.password_confirmation = " "}
        it{should_not be_valid}
    end

    describe 'Password tiene que pasar la confirmacion' do
        before { @user.password_confirmation = 'mismatch'}
        it {should_not be_valid}
    end

    describe 'password nil' do
        before { @user.password_confirmation = nil }
        it { should_not be_valid}
    end

    describe 'password to short' do
        before { @user.password = @user.password_confirmation = '1'*5}
        it{should_not be_valid}
    end

    describe 'return value authenticate method' do
        before { @user.save }
        let(:found_user) {User.find_by_email(@user.email)}

        describe "Password Valido" do
            it {should == found_user.authenticate(@user.password)}
        end
        describe "Password Invalido" do
            let(:user_for_invalid_password){found_user.authenticate("invalid")}
            it { should_not == user_for_invalid_password }
            specify { user_for_invalid_password.should be_false}
        end
    end

end
    