require 'dm-core'
require 'dm-migrations'
#require 'dm-sqlite-adapter'

def foundName?(inputName)
	@names.each do |entry|
		if inputName == entry.Name
			temp = Array.new;
			temp.push(@name)
			temp.push(entry.year1900)
			temp.push(entry.year1910)
			temp.push(entry.year1920)
			temp.push(entry.year1930)
			temp.push(entry.year1940)
			temp.push(entry.year1950)
			temp.push(entry.year1960)
			temp.push(entry.year1970)
			temp.push(entry.year1980)
			temp.push(entry.year1990)
			temp.push(entry.year2000)
			settings.dataArray.push(temp)
			return true
		end
	end
	return false
end


configure do 
	DataMapper.setup(:default,"sqlite://#{Dir.pwd}/Names.db")
end

class Name
	include DataMapper::Resource
	property :ID, Serial
	property :Name, String
	property :year1900, Integer
	property :year1910, Integer
	property :year1920, Integer
	property :year1930, Integer
	property :year1940, Integer
	property :year1950, Integer
	property :year1960, Integer
	property :year1970, Integer
	property :year1980, Integer
	property :year1990, Integer
	property :year2000, Integer

end

DataMapper.finalize()


get '/NameSurfer' do
	@names = Name.all
	if(params['name'])
		@name = params['name']
		@name = @name.gsub(/|^A-Za-z\-|/,'')

		if foundName?(@name.downcase)
			erb :graph
		else
			erb :notFound
		end
	end
end

#Searches database for name information
#Returns boolean depending if the name is found. 



