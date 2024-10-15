require_relative "readers/companies_reader"
require_relative "readers/user_reader"
require_relative "models/company"
require_relative "models/user"
require_relative "writer/file_writer"
require_relative "writer/report_writer"

def sort_by_last_name(users)
  users.sort_by! { |user| user[:name] }
end

companies_reader = CompaniesReader.new
user_reader = UserReader.new
f = FileWriter.new("output.txt")
report_writer = ReportWriter.new(f)

sorted_companies = companies_reader.companies.sort_by(&:id)

sorted_companies.each do |company|
  report_writer.set_company(company.name, company.id)
  total_top_up = 0

  user_reader.users.each do |user|
    next if user.company_id != company.id || !user.active_status

    total_top_up += company.top_up
    
    report_writer.add_user(user, company.top_up)
  end

  report_writer.set_total_top_up(total_top_up)
  report_writer.print_company
end

report_writer.print_document
