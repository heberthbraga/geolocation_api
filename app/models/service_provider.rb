class ServiceProvider < ApplicationRecord
  after_save :clear_cached_providers
  after_destroy :clear_cached_providers

  validates :name, presence: true, uniqueness: true
  validates :clazz_name, presence: true, uniqueness: true
  validates_presence_of :config_bundle, message: "can't be blank"

  def build_instance
    const = self.clazz_name.singularize

    Object.send(:remove_const, const) if self.class.const_defined?(const)

    Object.const_set(const, Class.new() do
      attr_reader :endpoint, :api_key, :lookup_address, :response_keys

      def initialize(config_bundle, lookup_address)
        parsed_config_bundle = Parser.parse_config_bundle(config_bundle)

        instance_variable_set("@endpoint", parsed_config_bundle[:endpoint])
        instance_variable_set("@api_key", parsed_config_bundle[:api_key])
        instance_variable_set("@lookup_address", lookup_address)
        instance_variable_set("@response_keys", parsed_config_bundle[:response_keys])
      end

      def get_address_path
        key_path = "#{api_key[:name]}=#{api_key[:value]}"

        "#{endpoint}/#{lookup_address}?#{key_path}"
      end
    end)
  end

  private

  def clear_cached_providers
    Cacher.flush_cached_providers
  end
end