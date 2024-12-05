$profanity_filter = LanguageFilter::Filter.new(
  matchlist: :profanity,
  replacement: :stars
)

additional_bad_words = [
  'abruti', 'bouffon', 'trouduc', 'pétasse', 'pouffiasse',
  'connard', 'enfoiré', 'salaud', 'Putain', 'Pute', 'Fille de pute',
  'bâtard', 'balourd', 'salopard', 'Bordel', 'Catin', 'Conne', 'Connasse',
  'Enculé', 'Pédé', 'PD', 'Pédale', 'Tapette', 'Tantouze', 'Fiotte',
  'Tafiole', 'Tarlouze', 'Sac à foutre', 'Petite bite', 'Couille molle',
  'Salope', 'Saloperie', 'Chienne', 'Cagole', 'Travelo', 'Gouine', 'Nègre',
  'Négro', 'Nigger', 'Nigga', 'Chintoque', 'Bougnoul', 'Mongol', 'Trisomique',
  'Triso', 'Pochtron', 'Pochtronne', 'Étron', 'Mange-merde', 'Tas de purin',
  'Trou du cul'
]

additional_bad_words.each do |word|
  $profanity_filter.matchlist << word
end
