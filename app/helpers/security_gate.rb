module SecurityGate
  def security_gate(*rules, &block)
    #todo test this
    #treats nonusers as below member

    #create a UserLevel object for comparison
    level = user_signed_in? ? current_user.level.to_sym : :nonuser
    ul = UserLevel.new(level)

    pass = true

    #expected vales for rules are an operator and a User Level, such as '> admin', which could also
    #be expressed as '= owner'
    rules.each do |rule|
      op = rule.split(' ')[0]
      level = rule.split(' ')[1]
      pass = false unless ul.send(op.to_sym, level.to_sym)
    end
    capture(&block) if pass
  end
end