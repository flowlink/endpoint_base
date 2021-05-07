require File.join(File.dirname(__FILE__), '../spec_helper')

describe FailingController, type: 'controller' do

  let(:config) { [{ 'name' => 'spree.api_key', 'value' => '123' },
                  { 'name' => 'spree.api_url', 'value' => 'http://localhost:3000/api/' },
                  { 'name' => 'spree.api_version', 'value' => '2.0' }] }

  let(:message) {{ 'store_id' => '123229227575e4645c000001',
                   'request_id' => 'abc',
                   'parameters' => config }}


  it "renders the 500.json page on exceptions" do
    post :index, params: message

    expect(response.code).to eq('500')
    expect(json_response['summary']).to eq('I see dead people')
    expect(json_response['request_id']).to eq('abc')
  end

  it "return 401 on authorization failues" do
    request.env['HTTP_X_HUB_TOKEN'] = 'wrong'
    post :index, params: message

    expect(response.code).to eq('401')
    expect(json_response['text']).to eq('unauthorized')
  end

  it 'can set response code and set summary with a single call' do
    post :failure, params: message

    expect(response.code).to eq('500')
    expect(json_response['summary']).to eq('this was a failure')
  end
end
