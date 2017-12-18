class Variant < ApplicationRecord
  acts_as_importable
  attr_accessor :name, :description
  require 'csv'

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attribute.values_at(*column_names)
      end
    end
  end

  def self.import(file)
    csv_text = File.read(Rails.root.join('lib', 'seeds', file.path))
    csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
    csv.each do |row|
      t = Variant.new
      t.name = row['name']
      t.description = row['description']
      t.save!
      puts "#{t.name}, #{t.description} saved"
    end

    # CSV.foreach(file.path, headers: true) do |row|
    #   Variant.create! row.to_hash
    # end
  end
end
