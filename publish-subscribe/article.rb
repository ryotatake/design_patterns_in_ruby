class Publisher
  def initialize(topic)
    @topic = topic
  end

  def publish(message)
    ContentServer.get_instance.send_message(@topic, message)
  end
end

class ContentServer
  def self.get_instance
    @@server_instance ||= ContentServer.new
  end

  def initialize
    @subscriber_lists = {}
  end

  def send_message(topic, message)
    subscribers = @subscriber_lists[topic] || []

    subscribers.each do |subscriber|
      subscriber.received_message(topic, message)
    end
  end

  def register_subscriber(subscriber, topic)
    @subscriber_lists[topic] ||= []
    @subscriber_lists[topic] << subscriber
  end
end

class Subscriber
  def initialize(*topics)
    subscribe(*topics)
  end

  def subscribe(*topics)
    topics.each do |topic|
      ContentServer.get_instance.register_subscriber(self, topic)
    end
  end

  def received_message(topic, message)
    puts message
  end
end

qiita    = Publisher.new(:qiita)
sankei   = Publisher.new(:sankei)
yomiuri  = Publisher.new(:yomiuri)

takeuchi = Subscriber.new(:qiita, :sankei)
kato     = Subscriber.new
kato.subscribe(:qiita, :yomiuri)

qiita.publish("Qiita published!")
sankei.publish("sankei published!")
yomiuri.publish("yomiuri published!")
