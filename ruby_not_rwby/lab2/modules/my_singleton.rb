module MySingleton
  def new(*args, &block)
    @@singleton ||= super(*args, &block)
  end

  def singleton
    @@singleton
  end
end