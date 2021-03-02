names = ['alice', 'white-rabbit', 'chechire-cat']
threads = []

threads = names.reduce([]) do |array, name|
  array.push(Thread.new do
    3.times { |i| puts("#{name}:#{i}") }
  end)
end

threads.each { |t| t.join }

puts('end')