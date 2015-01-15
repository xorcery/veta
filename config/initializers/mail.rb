SENDGRID_CONFIG = YAML.load_file("#{Rails.root}/config/sendgrid.yml")[Rails.env]

ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => SENDGRID_CONFIG['username'],
  :password       => SENDGRID_CONFIG['password'],
  :domain         => 'veta.imulus.io'
}
ActionMailer::Base.delivery_method = :smtp