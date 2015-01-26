class Spinach::Features::NewUser < Spinach::FeatureSteps
  step 'I am logged in as an administrator' do
    FactoryGirl.create(:user, email: "test@example.com", password: "password", password_confirmation: "password", is_administrator: true)
    visit '/'
    fill_in('user_email', with: "test@example.com")
    fill_in('user_password', with: "password")
    click_button("Log in")
    page.should have_content("Logged in as")
  end

  step 'I create a new user "someone@example.com"' do
    visit '/users'
    visit '/users/new'
  end

  step 'an email with a password reset link should be added to the delayed jobs' do
    pending 'step not implemented'
  end

  step 'when the email is sent' do
    pending 'step not implemented'
  end

  step 'in a new browser session' do
    pending 'step not implemented'
  end

  step 'they should be able to see the email' do
    pending 'step not implemented'
  end

  step 'click "password reset"' do
    pending 'step not implemented'
  end
end
