Dir[File.join(Rails.root, 'db', "seeds/#{Rails.env.downcase}", '*.rb')].sort.each do |seed|
  if File.exist?(seed)
    p 'Seeding for ' + File.basename(seed, '.*')
    load(seed)
  end
end