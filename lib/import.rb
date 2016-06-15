require 'csv'
class Import
   file=[]
   class << self
    def from_csv
     file= CSV.read("#{Rails.root}/log/BIB-pro.csv") 
      tax=file.map do |i|i[14] end
        tax1=tax.map do |a|a.split(/>/) end
          tax1.map do |csv|
          
       taxon=Taxon.new(:main_cat_name=>csv[0])
        taxon.save(:validate=>false)
    end
end
end
end

