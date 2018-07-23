namespace :gprs do
  desc "Rake Tasks"
  task minute_run: :environment do
    orders = Order.where(success: false)
    orders.all.destroy_all
  end
end