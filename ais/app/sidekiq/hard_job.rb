class HardJob
  include Sidekiq::Job

  def perform(*args)
    Rails.logger.info("coba")
    `echo 'test' > /tmp/coba`
    # Do something
  end
end
