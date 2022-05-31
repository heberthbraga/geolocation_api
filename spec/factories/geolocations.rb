FactoryBot.define do
  factory :geolocation, class: Geolocation do
    id { 20 }
    lookup_address { '2804:14d:1289:8f37:318e:932:6fea:f519' }
    lookup_type { 'ipv6' }
    country_code { 'BR' }
    country_name { 'Brazil' }
    region_code { 'SP' }
    region_name { 'Sao Paulo' }
    city { 'São Paulo' } 
    latitude { -23.54749870300293 }
    longitude { -46.6361083984375 }
  end
end