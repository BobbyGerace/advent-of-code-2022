class Directory
  attr_reader :name, :directories

  ElfFile = Struct.new(:name, :size)

  def initialize(name)
    @name = name
    @files = []
    @directories = []
  end

  def add_child_dir(dir)
    @directories.push(dir) unless @directories.any? { |d| d.name == dir.name }
  end

  def add_file(name, size)
    file = ElfFile.new(name, size)
    @files.push(file) unless @files.any? { |f| f == file }
  end

  def size
    @files.map(&:size).sum + @directories.map(&:size).sum
  end

  def find_dirs(&block)
    result = []

    result << self if block.call self
    @directories.each do |d|
      result += d.find_dirs(&block)
    end

    result
  end
end


class OutputParser
  attr_reader :root_dir
  def initialize
    @root_dir = Directory.new("/")
    @directory_stack = [@root_dir]
  end

  def stack_top
    @directory_stack.last
  end

  def ingest_command(line)
    if line[0,6] == "$ cd /"
      @directory_stack = [@root_dir]
    elsif line[0,7] == "$ cd .."
      @directory_stack.pop
    elsif line[0,4] == "$ cd"
      dir = Directory.new(line[5..])
      stack_top.add_child_dir(dir)
      @directory_stack.push(dir)
    end
  end

  def ingest_file(line)
    size, name = line.strip.split(" ")
    stack_top.add_file(name, size.to_i)
  end

  def ingest(line)
    if (line[0] == "$")
      ingest_command(line)
    elsif (line[0] =~ /\d/)
      ingest_file(line)
    end
  end
end

parser = OutputParser.new
File.open('input-7.txt').each do |line|
  parser.ingest(line)
end

small_dirs = parser.root_dir.find_dirs do |dir|
  dir.size <= 100_000
end

puts small_dirs.map(&:size).sum
