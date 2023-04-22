require 'rails_helper'

RSpec.describe "Birds", type: :request do
  # describe "GET /index" do
  #   pending "add some examples (or delete) #{__FILE__}"
  # end

  let(:bird) { Bird.new(name: "a bird", description: "a description")}
  let(:birds) {[bird]}

  describe "GET /birds" do
    #before hooks are run before each example

    #we dont want UT to call DB directly
    # :all method return 'birds' object
    before {allow(Bird).to receive(:all).and_return(birds)}
  end

  it 'returns list of birds' do
    get '/birds'
    #kita expect response nya sama dengan birds dalam bentuk json
    expect(response.body) == (birds.to_json)
  end

  describe "POST /birds" do
    before {allow_any_instance_of(Bird).to receive(:save!)}

    context 'validation fails' do
      it 'returns validation error' do
        #....
        post '/birds', :params => {bird: {name: '', description: ''}}
        expect(JSON.parse(response.body)).to eq([
          {
            "field"=> "name",
            "message"=> "Name can't be blank"
          },
          {
            "field"=> "description",
            "message"=> "Description can't be blank"
          }
        ])
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'successful' do
      it 'returns a bird' do 
        post '/birds', :params => {bird: {name: 'a bird', description: 'a description'}}
        expect(JSON.parse(response.body)).to include(
          {"name" => "a bird", "description" => "a description"}
        )
      end
    end

  end
end
