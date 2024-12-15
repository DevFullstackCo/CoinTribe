$profanity_filter = LanguageFilter::Filter.new(
  matchlist: :profanity,
  replacement: :stars
)

additional_bad_words = [
  'バカ', 'アホ', 'クソ', 'バカ野郎', 'クソガキ',

  '死ね', 'この野郎', '最低', 'アホンダラ', 'デブ',

  'ハゲ', '間抜け', 'チビ', 'うざい', 'ぶさいく',

  'tabarnak', 'Baka', 'Aho', 'Kuso', 'Baka yarou',

  'Kuso gaki', 'Shine', 'Kono yarou', 'Saitei', 'Ahondara',

  'Debu', 'Hage', 'Manuke', 'Chibi', 'Uzai', 'Busaiku'
]

additional_bad_words.each do |word|
  $profanity_filter.matchlist << word
end

