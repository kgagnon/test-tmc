require_relative "json_reader"

class CompaniesReader < JsonReader
  attr_reader :companies

  def initialize
    super("companies.json")
    @companies = map_companies
    validate_data
  end

  def validate_data
    @data.each do |company|
      unless company["id"] && company["name"] && company["top_up"].is_a?(Numeric)
        raise "Invalid company data: #{company}"
      end
    end
  end

  private

  def map_companies
    @data.map do |company_data|
      Company.new(company_data["id"], company_data["name"], company_data["top_up"], company_data["email_status"])
    end
  end
end
