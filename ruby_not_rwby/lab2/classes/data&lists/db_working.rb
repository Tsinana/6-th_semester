require 'sqlite3'
require_relative '../../modules/my_singleton'

class DBWorking
	include MySingleton

	def initialize()
		puts "DB1"
		@db = SQLite3::Database.open '../../../data/students.db'
		@db.results_as_hash = true
		puts "DB2"
	end

	def execute(query, *args)
    @db.execute(query,*args)
  end

  def results_as_hash=(bool)
    @db.results_as_hash = bool
  end
end

puts DBWorking.ancestors