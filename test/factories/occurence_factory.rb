
Factory.define :occurence do |f|
  f.association :error, :factory => :error
  f.properties( 'hello' => 'world' )
end
