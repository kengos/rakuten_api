# coding: utf-8

module RakutenApi::Base
  class Model
    def to_hash
      {}.tap do |h|
        instance_variables.each do |sym|
          h[sym.to_s.sub('@', '').to_sym] = instance_variable_get(sym)
        end
      end
    end

    class << self
      def from_hash(hash)
        obj = self.new
        mapping.each_pair do |k, v|
          next unless hash.include?(k)
          if v.is_a?(Array) && v[1].respond_to?(:call)
            obj.send("#{v[0]}=", v[1].call(hash[k]))
          else
            obj.send("#{v}=", hash[k])
          end
        end
        obj
      end

      def mapping
        raise "not implement"
      end
    end
  end
end