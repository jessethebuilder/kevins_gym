module SecurityGate
  def user_passes_locks?(locks)
    #treats nonusers as below member
    level = user_signed_in? ? current_user.level : 'nonuser'

    #create a UserLevel object for comparison
    pass = true

    #expected vales for rules are an operator and a User Level, such as '> admin'
    locks.each do |rule|
      #the special rule = current_user means a pass if the current_user
      op = rule.split(' ')[0]
      threshold = rule.split(' ')[1]
      pass = false unless User::USER_LEVELS.index(level).send(op.to_sym, User::USER_LEVELS.index(threshold))
    end

    pass
  end

  def security_gate(gate, key, record = nil, record_owner_key: :user_id, &block)
    rules = SECURITY_GATES[gate][key]
    capture(&block) if user_passes_locks?(rules) || user_owns?(record, :owner_key => record_owner_key)
  end
  
  def user_owns?(record, owner_key: :user_id)
    if user_signed_in? && record
      record.send(owner_key) == current_user.id
    end
  end

  SECURITY_GATES = {'top_nav' => {
                        'tools_menu' => ['>= admin']
                    },
                    'event' => {
                        'edit_from_show' => ['>= admin']
                    },
                    'news_story' => {
                        'edit_author_of_news_story' => ['>= admin'],
                        #'set_author_with_hidden' => ['== staff'],
                        'show_quick_menu' => ['>= admin'],
                        'index_edit_story' => ['>= admin']
                    },
                    'edit_link' => {
                        'view' => ['>= admin']
                    },
                    'quick_options' => {
                        'view' => ['>= admin']
                    }


  }


end