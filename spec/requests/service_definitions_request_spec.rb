require 'rails_helper'

RSpec.describe "ServiceDefinitions", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/service_definitions/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/service_definitions/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/service_definitions/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/service_definitions/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/service_definitions/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/service_definitions/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /delete" do
    it "returns http success" do
      get "/service_definitions/delete"
      expect(response).to have_http_status(:success)
    end
  end

end
