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
        hash.each_pair do |k, v|
          v = casting[k].call(v) if casting.include?(k)
          attribute = mapping.include?(k) ? mapping[k] : downcase(k)
          obj.send("#{attribute}=", v) if obj.respond_to?("#{attribute}=")
        end
        obj
      end

      def downcase(word)
        _word = word.dup
        _word.gsub!(/([A-Z\d]+)([A-Z][a-z])/,'\1_\2')
        _word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
        _word.downcase!
        _word
      end

      def mapping
        {}
      end

      def casting
        {}
      end
    end
  end
end