require 'open3'

class FabricNetwork
  def self.reset
    Rails.logger.info("resetting blockchain...")
    starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    stdout, stdeerr, status = Open3.capture3("../reset.sh")

    Rails.logger.info(stdout)

    ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    elapsed = ending - starting
    Rails.logger.info("done in #{elapsed}")
  end
end