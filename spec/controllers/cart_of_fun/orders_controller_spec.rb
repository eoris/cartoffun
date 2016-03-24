require 'rails_helper'

module CartOfFun
  RSpec.describe OrdersController, type: :controller do
    routes { CartOfFun::Engine.routes }

    let(:order)    { create(:cart_of_fun_order) }
    let(:customer) { create(:user) }

    context "GET #index" do
      context "when customer signed in" do
        before do
          sign_in(customer)
          get :index
        end

        it 'render :index template' do
          expect(response).to render_template(:index)
        end

        it "returns http success" do
          expect(response).to have_http_status(:success)
        end
      end
    end

    context 'GET #show' do
      context "when customer signed in" do
        before do
          sign_in(customer)
          get :show, id: order.id
        end

        it 'render show template' do
          expect(response).to render_template(:show)
        end

        it "returns http success" do
          expect(response).to have_http_status(:success)
        end
      end
    end
  end
end
