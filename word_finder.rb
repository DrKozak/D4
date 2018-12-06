require_relative 'path.rb'
require_relative 'graph.rb'




def incorrect_arguments
  puts "Incorrect amount of arguments"
  exit 1
end


def incorrect_file_type
  puts 'File cannot be located'
  exit 1
end


# Must have one argument for it to be valid
def valid_num_args?(args)
  args.count == 1
rescue StandardError
  false
end



incorrect_arguments unless valid_num_args?(ARGV)
incorrect_arguments unless File.file?(ARGV[0])
get_words(ARGV[0])