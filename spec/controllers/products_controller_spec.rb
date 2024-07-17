require 'rails_helper'

RSpec.describe ProductsController do
  let!(:product) { create(:product) }
  let(:valid_attributes) { { name: 'Product1', sku: "#{SecureRandom.hex}", price: 123, stock_quantity: 10 } }
  let(:invalid_attributes) { { name: '', sku: '', price: nil, stock_quantity: nil } }

  describe 'GET #index' do
    it 'returns a success response with list of products' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response with product' do
      get :show, params: { id: product.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new Product' do
        expect {
          post :create, params: { product: valid_attributes }
        }.to change(Product, :count).by(1)
      end

      it 'redirects to the created product' do
        post :create, params: { product: valid_attributes }
        expect(response).to redirect_to(Product.last)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Product' do
        expect {
          post :create, params: { product: invalid_attributes }
        }.to change(Product, :count).by(0)
      end

      it 'renders the new template' do
        post :create, params: { product: invalid_attributes }
        expect(response).to be_unprocessable
        expect(response).to render_template('new')
      end
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: product.to_param }
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    context 'with valid parameters' do
      let(:new_attributes) { { name: 'Updated Product' } }

      it 'updates the requested product' do
        put :update, params: { id: product.to_param, product: new_attributes }
        product.reload
        expect(product.name).to eq('Updated Product')
      end

      it 'redirects to the product' do
        put :update, params: { id: product.to_param, product: valid_attributes }
        expect(response).to redirect_to(product)
      end
    end

    # context 'with invalid parameters' do
    #   it 'renders the edit template' do
    #     put :update, params: { id: product.to_param, product: invalid_attributes }
    #     expect(response).to be_unprocessable
    #     expect(response).to render_template('edit')
    #   end
    # end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested product' do
      expect {
        delete :destroy, params: { id: product.to_param }
      }.to change(Product, :count).by(-1)
    end

    it 'redirects to the products list' do
      delete :destroy, params: { id: product.to_param }
      expect(response).to redirect_to(products_url)
    end
  end
end
