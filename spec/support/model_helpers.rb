module ModelHelpers
  def has_error(obj, attr, msg)
    obj.valid?
    obj.errors.messages[attr].include?(msg)
  end
end

RSpec.configure do |config|
  config.include ModelHelpers, :type => :model
end