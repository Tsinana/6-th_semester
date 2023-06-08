#этот подход имеет проблему с наследованием - каждый подкласс будет использовать ту же самую переменную @@singleton
module MySingleton
  def new(*args, &block)
    @@singleton ||= super(*args, &block)
  end

  def singleton
    @@singleton
  end
end