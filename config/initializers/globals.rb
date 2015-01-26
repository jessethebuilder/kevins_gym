def symbols_and_strings(symbol_array)
  symbol_array.collect{ |sym| [sym, sym.to_s] }.flatten
end

#NS = NewsStory
#
SOCIAL_NETWORKING = {
    :facebook => { :fanpage => 'Sequim-Gym/414083728647866',
                   :id => '140936849442574',
                   :secret => 'b2ee51123324b8cfabfd8fe14ff731e2'},
    :twitter => { :fanpage => 'anysoftdotus'}
}
