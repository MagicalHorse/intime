# encoding: utf-8
require 'eventmachine'
require 'sqs_subscriber'

module ISAwsSqs
  def self.start
    if defined?(PhusionPassenger)
       PhusionPassenger.on_event(:starting_worker_process) do |forked|
        # for passenger, we need to avoid orphaned threads
        if forked && EM.reactor_running?
         EM.stop
        end
        Thread.new {
          EM.run do
            #AMQP.channel ||= AMQP::Channel.new(AMQP.connect(:host=> Q_SERVER, :user=> Q_USER, :pass => Q_PASS, :vhost => Q_VHOST ))
            sqs_setup unless Rails.env.development?
          end
        }
        die_gracefully_on_signal
        end
    else
    # faciliates debugging
    Thread.abort_on_exception = true
    # just spawn a thread and start it up
    Thread.new {
        EM.run do
          #AMQP.channel ||= AMQP::Channel.new(AMQP.connect(:host=> Q_SERVER, :user=> Q_USER, :pass => Q_PASS, :vhost => Q_VHOST ))
          sqs_setup unless Rails.env.development?
        end
      } unless defined?(Thin)
    # Thin is built on EventMachine, doesn't need this thread
    end
  end

  def self.die_gracefully_on_signal
    Signal.trap("INT") { EM.stop }
    Signal.trap("TERM") { EM.stop }
  end
  def self.sqs_setup
    sqs = AWS::SQS.new
    q = sqs.queues.create 'sql2mysql'
    Rails.logger.info 'create/get queue success'
    EventMachine.add_timer {
      Rails.logger.info 'start polling message...'
      q.poll(:wait_time_seconds => 20,:batch_size=>10) do |msg|
        msg_data = msg.body
        ISAwsSqs::Subscriber.dispatch msg_data

      end
     }
  end
end

#ISAwsSqs.start unless Rails.env.development?
