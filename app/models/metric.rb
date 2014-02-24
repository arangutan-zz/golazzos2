class Metric
	attr_reader :title, :column_one_name, :column_two_name, :rows
	def initialize(args={})
		@title					 = args.fetch(:title,"Metrica no encontrada")
		@column_one_name = args.fetch(:column_one_name, "no definido")
		@column_two_name = args.fetch(:column_two_name, "no definido")
		@rows 				   = args.fetch(:rows, [["-","-"]])
	end
end