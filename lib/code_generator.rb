module CodeGenerator # Generate a random code 
  def self.generate
    rand(100000...999999).to_s
  end
end



