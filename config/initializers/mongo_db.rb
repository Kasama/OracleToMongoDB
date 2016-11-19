class MongoDB
  # load YAML and connect
  database_yaml = YAML.load(File.read "#{Rails.root}/config/mongodb.yml")
  puts '=> Initializing MongoDB...'
  if database_yaml[Rails.env] && database_yaml[Rails.env]['adapter'] == 'MongoDB'
    db = database_yaml[Rails.env]
    MongoMapper.connection = Mongo::Connection.new(db['host'], db['port'], db['pool_size'], db['timeout'])
    MongoMapper.database = db['database']
  end
  puts '=> Successfully initialized MongoDB'
end
