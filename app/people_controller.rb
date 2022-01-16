require "time"

class PeopleController
  def initialize(params)
    @params = params
  end

  def normalize
    dollar_data = dollar_formatted_data
    percent_data = percent_formatted_data
    final_array = dollar_data + percent_data
    sorted_array = final_array.sort_by{|t| t[0].strip}
    sorted_array.collect{|row| row.join(",")}
  end

  private

  def dollar_formatted_data
    dollar_format = @params[:dollar_format].split("\n")
    dollar_format_header = dollar_format.shift
    dollar_format_data = dollar_format
    row_without_dollor = []
    dollar_format_data.each do |row|
      reverse_row = row.split('$').reverse
      reverse_row.delete_at(1)
      reverse_row[1], reverse_row[2] = reverse_row[2], reverse_row[1]
      reverse_row[-1] = Time.parse(reverse_row.last.strip).strftime("%m/%d/%Y").gsub(/^0/, '')
      row_without_dollor << reverse_row
    end
    row_without_dollor
  end

  def percent_formatted_data
    percent_format = @params[:percent_format].split("\n")
    percent_format_header = percent_format.shift
    percent_format_data = percent_format
    row_without_percent = []
    percent_format_data.each do |row|
      spitted_array = row.split('%')  
      spitted_array[-1] = Time.parse(spitted_array[-1].strip).strftime("%m/%d/%Y").gsub(/^0/, '')
      row_without_percent << spitted_array
    end
    row_without_percent
  end

  attr_reader :params
end
