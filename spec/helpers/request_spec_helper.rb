module RequestSpecHelper
  def json_response
    expect(response).not_to be_nil
    expect(response.body).not_to be_nil

    JSON.parse(response.body, symbolize_names: true)
  end

  def expect_forbidden_error
    error = expect_error_response
    
    expect(error[:title]).to eq Error::Title::FORBIDDEN
    expect(error[:status].to_i).to eq Error::Status::FORBIDDEN
  end

  def expect_unauthorized_error
    error = expect_error_response

    expect(error[:title]).to eq Error::Title::UNAUTHORIZED
    expect(error[:status].to_i).to eq Error::Status::UNAUTHORIZED
  end

  def expect_not_found_error
    error = expect_error_response

    expect(error[:title]).to eq Error::Title::RECORD_NOT_FOUND
    expect(error[:status].to_i).to eq Error::Status::RECORD_NOT_FOUND
  end

  def expect_validation_error(quantity)
    response = json_response
    expect(response).not_to be_empty

    title = response[:title]
    expect(title).to eq Error::Title::VALIDATION_FAILED

    errors = response[:errors]
    expect(errors.size).to eq quantity
    errors.each do |error|
      expect(error[:resource]).not_to be_nil
      expect(error[:field]).not_to be_nil
      expect(error[:code]).not_to be_nil
    end
  end

  def expect_read_timeout_error
    error = expect_error_response

    expect(error[:title]).to eq Error::Title::READ_TIMEOUT_ERROR
    expect(error[:status].to_i).to eq Error::Status::TIMEOUT
  end

  def ipstack_provider_response
    {
      :ip=>"2804:14d:1289:8f37:a408:5ac9:5390:e68c",
      :type=>"ipv6",
      :continent_code=>"SA",
      :continent_name=>"South America",
      :country_code=>"BR",
      :country_name=>"Brazil",
      :region_code=>"SP",
      :region_name=>"São Paulo",
      :city=>"São Paulo",
      :zip=>nil,
      :latitude=>-23.54749870300293,
      :longitude=>-46.6361083984375,
      :location=> {
        :geoname_id=>3448439,
        :capital=>"Brasília",
        :languages=>[{:code=>"pt", :name=>"Portuguese", :native=>"Português"}],
        :country_flag=>"https://assets.ipstack.com/flags/br.svg",
        :country_flag_emoji=>"🇧🇷",
        :country_flag_emoji_unicode=>"U+1F1E7 U+1F1F7",
        :calling_code=>"55",
        :is_eu=>false
      }
    }
  end

  def ipsatck_error_response
    {
      :success=>false, 
      :error=>{
        :code=>106, 
        :type=>"invalid_ip_address", 
        :info=>"The IP Address supplied is invalid."
      }
    } 
  end

  private

  def expect_json_response
    response = json_response
    expect(response).not_to be_empty
    response
  end

  def expect_error_response
    response = expect_json_response
    
    error = response[:errors].first
    expect(error).not_to be_empty
    error
  end
end