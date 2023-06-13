# этот подход имеет проблему с наследованием - каждый подкласс будет использовать ту же самую переменную @@singleton
module MySingleton
  def new(*args, &block)
    puts "myS1"
    @@singleton ||= super(*args, &block)
    puts "myS2"
  end

  def singleton
    @@singleton
  end
end