require "rails_helper"

RSpec.describe Api::ImagesController, type: :controller do
  before do
    create(:image)
    create(:image, :deleted)
    create(:image, :r18)
  end

  describe "GET" do
    it "all" do
      get :index, params: { target_type: "all" }
      body = JSON.parse(response.body)

      expect(body.count).to eq(2)
      expect(body[0]["target_type"]).to eq("r18")
      expect(body[1]["target_type"]).to eq("normal")
    end

    it "only r18" do
      get :index, params: { target_type: "r18" }
      body = JSON.parse(response.body)

      expect(body.count).to eq(1)
      expect(body[0]["target_type"]).to eq("r18")
    end

    it "only normal" do
      get :index, params: { target_type: "normal" }
      body = JSON.parse(response.body)

      expect(body.count).to eq(1)
      expect(body[0]["target_type"]).to eq("normal")
    end
  end
end
