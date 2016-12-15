RSpec.describe Spree::StaticContentController, type: :controller do
  let!(:store) { create(:store, default: true) }

  before do
    allow(controller).to receive(:spree_current_user).and_return(nil)
    allow(controller).to receive(:current_store).and_return(store)
  end

  context '#show' do
    it 'accepts path as root' do
      page = create(:page, slug: '/', stores: [store])
      request.path = page.slug
      spree_get :show, path: page.slug
      expect(response).to be_success
    end

    it 'accepts path as string' do
      page = create(:page, slug: 'hello', stores: [store])
      request.path = page.slug
      spree_get :show, path: page.slug
      expect(response).to be_success
    end

    it 'accepts path as nested' do
      page = create(:page, slug: 'aa/bb/cc', stores: [store])
      request.path = page.slug
      spree_get :show, path: page.slug
      expect(response).to be_success
    end

    it 'respond with a 404 when no page exists' do
      spree_get :show
      expect(response.response_code).to be(404)
    end

    it 'activates Spree::PromotionHandler::Page handler' do
      page = create(:page, slug: 'promo', stores: [store])
      current_order = double(:order)
      allow(controller).to receive(:current_order).and_return(current_order)
      allow(controller.request).to receive(:path).and_return(page.slug)
      expect(Spree::PromotionHandler::Page).to receive(:new).with(current_order, page.slug).and_return(double(:handler, activate: true))
      spree_get :show, path: page.slug
    end
  end
end
