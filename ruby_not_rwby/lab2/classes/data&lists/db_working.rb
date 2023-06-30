require 'sqlite3'
require_relative '../../modules/my_singleton'

class DBWorking
	include MySingleton

	def initialize()
		@db = SQLite3::Database.open 'C:\Users\sinana\GitHub\6-th_semester\ruby_not_rwby\lab2\data\students.db'
		@db.results_as_hash = true
	end

	def execute(query, *args)
    @db.execute(query,*args)
  end

  def results_as_hash=(bool)
    @db.results_as_hash = bool
  end
end