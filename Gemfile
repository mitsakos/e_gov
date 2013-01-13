source 'https://rubygems.org'
ruby '1.9.3'

# Standard gems used in all environments
gem 'rails', '3.2.8'
gem 'mysql2'
gem 'jquery-rails'
gem 'bcrypt-ruby', :require => 'bcrypt' # Bcrypt gem needed for user password encryption
gem 'paperclip', "~> 3.0" # Paperclip gem for uploading images
gem 'cells' # Cells gem for reusable sidebar components
gem 'watu_table_builder', :require => "table_builder" # Table_builder gem for calendar table creation
gem 'nokogiri' # Nokogiri gem for screen scraping
gem 'kaminari' # Kaminari gem for pagination
gem 'active_attr' # Active_attr gem for tableless models with active record behaviour

# Gems used only in the
# development environment
group :development do
	gem 'annotate' # Annotate gem for automatic model annotation
end

group :production do
	gem 'thin'
	gem 'pg'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
	gem 'sass-rails',   '~> 3.2.3'
	gem 'coffee-rails', '~> 3.2.1'
	gem 'uglifier', '>= 1.0.3'
end