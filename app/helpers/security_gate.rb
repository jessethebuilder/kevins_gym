module SecurityGate
  def user_passes_locks?(locks)
    #treats nonusers as below member
    level = user_signed_in? ? current_user.level.to_sym : :nonuser

    #create a UserLevel object for comparison
    ul = UserLevel.new(level)

    pass = true

    #expected vales for rules are an operator and a User Level, such as '> admin', which could also
    #be expressed as '= owner'
    locks.each do |rule|
      #the special rule = current_user means a pass if the current_user
      op = rule.split(' ')[0]
      level = rule.split(' ')[1]
      pass = false unless ul.send(op.to_sym, level.to_sym)
    end

    pass
  end

  def security_gate(gate, key, object_to_check_for_ownership = nil,  &block)
    #if an object_to_check_for_ownership is passed, block will be executed if current_user owns the object (if object has
    # as user_id that equals current_user.id)
    if user_signed_in? && object_to_check_for_ownership
      object_ownership = object_to_check_for_ownership.user_id == current_user.id
    end
    rules = SECURITY_GATES[gate][key]
    pass = user_passes_locks?(rules) || object_ownership
    capture(&block) if pass
  end

  SECURITY_GATES = {'top_nav' => {
                        'tools_menu' => ['>= staff']
                    },
                    'event' => {
                        'edit_from_show' => ['>= admin']
                    },
                    'news_story' => {
                        'edit_author_of_news_story' => ['>= admin'],
                        'set_author_with_hidden' => ['== staff']
                    }

  }


end