require 'rails_helper'

RSpec.describe "Newsletters", type: :request do
  describe "POST /create" do
    it 'create a new newsletter' do
      expect {
        post '/newsletters', params: {email: 'john@doe.com', woman_fashion: "0", man_fashion: "1", kid_fashion: "1"}
      }.to change { Newsletter.count }.from(0).to(1)
    end
  end
end
