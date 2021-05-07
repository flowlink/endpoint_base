require File.join(File.dirname(__FILE__), '../spec_helper')

describe HappyController, type: 'controller' do

  let(:config) { [{ 'name' => 'spree.api_key', 'value' => '123' },
                  { 'name' => 'spree.api_url', 'value' => 'http://localhost:3000/api/' },
                  { 'name' => 'spree.api_version', 'value' => '2.0' }] }

  let(:message) {{ 'store_id' => '123229227575e4645c000001',
                   'requet_id' => 'abc',
                   'parameters' => config }}


  it 'render populated response' do
    post :index, params: message

    expect(response.code).to eq('200')

    expect(json_response['products'].size).to eq(1)
    product = json_response['products'].first
    expect(product['id']).to eq(1)

    expect(json_response['parameters']['spree.order_poll.last_updated_at']).to eq('today')
    expect(json_response['summary']).to eq('today is a good day to ...')
  end

  it 'can set response code and set summary with a single call' do
    post :success, params: message

    expect(response.code).to eq('200')
    expect(json_response['summary']).to eq('this was a success')
  end
end
