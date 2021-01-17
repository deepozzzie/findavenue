json.extract! company, :id, :name, :address, :lat, :lng, :phone_number, :link, :capacity, :created_at, :updated_at
json.url company_url(company, format: :json)
