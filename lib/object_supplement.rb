module ObjectSupplement
  def send_chain(*array)
    array.inject(self) { |object, element| object.send(*element) }
  end
end
