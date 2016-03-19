require 'rails_helper'

describe UsersController do
  let(:user) { build(:user) }
  let(:second_user) { build(:user)}
  let(:password) { attributes_for(:user)[:password] }
  describe '#create' do
    context 'when given valid credentials' do
      it {
        post :create, { name: user.name, email: user.email, password: password,gender:"male" }
        expect(user.gender).to eq "male"
        is_expected.to respond_with :ok
      }
    end

    context 'when given invalid credentials' do
      it {
        post :create, { name: user.name, password: password }
        #expect(response.body).to render_template 'v2/retailer/companies/create'
        is_expected.to respond_with 400
      }
    end

  end



end

