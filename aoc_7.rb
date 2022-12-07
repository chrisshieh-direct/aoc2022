def create_structure
  instructions = []
  File.readlines('aocdata.txt').each do |line|
    instructions << line.chomp
  end

  hierarchy = []
  filesystem = Hash.new({})
  current_dir = filesystem

  instructions.each do |input|
    case input[0]
    when '$'
      if input[2] == 'c'
        if input[-1] == '.'
          current_dir = hierarchy.pop
        else
          hierarchy << current_dir
          current_dir = current_dir[input[5..]]
        end
      end
    when 'd'
      unless current_dir[input[4..]]
        current_dir[input[4..]] = {}
      end
    when /[0-9]/
      data = input.split
      filesize = data.first
      filename = data.last
      current_dir[filename] = filesize.to_i
    end
  end

  # PART ONE
  below_100000 = []
  total_used = calculate_dir_size(filesystem[:/], below_100000, 0)
  puts "PART ONE: Dirs under 100_000 sum is #{below_100000.reduce(:+)}"
  p below_100000

  # PART TWO
  equal_or_more_than_6975962 = []
  total_used = calculate_dir_size(filesystem[:/], equal_or_more_than_6975962, 0)
  current_free = 70_000_000 - total_used
  needed_space = 30_000_000 - current_free
  puts "PART TWO: Total used space is #{total_used}. Total filesystem space"
  puts "is 70_000_000. We need 30_000_000. Current free space is #{current_free}."
  puts "So we look for #{needed_space}."
  p equal_or_more_than_6975962.min
end

def calculate_dir_size(hsh, array, indent)
  this_level_total = 0
  folders_below = 0
  hsh.each do |k, v|
    if v.is_a? Integer
      # p "#{k} is a file of size #{v}"
      this_level_total += v
    elsif v.is_a? Hash
      folders_below = calculate_dir_size(v, array, indent + 2)
      # puts ("-" * indent) + "- #{k}: #{folders_below}"
      this_level_total += folders_below
    end
  end

  array << this_level_total if this_level_total < 100_000
  # array << this_level_total if this_level_total >= 6975962
  this_level_total
end

create_structure
