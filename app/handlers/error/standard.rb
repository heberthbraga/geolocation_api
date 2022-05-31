module Error
  class Standard < ::StandardError
    def initialize(title: nil, detail: nil, status: nil, source: {})
      @title = title || Error::Message::DEFAULT_TITLE_ERROR
      @detail = detail || Error::Message::DEFAULT_DETAIL_ERROR
      @status = status || 500
      @source = source.deep_stringify_keys
    end

    def to_h
      {
        status: status,
        title: title,
        detail: detail,
        source: source
      }
    end

    def serializable_hash
      to_h
    end

    delegate :to_s, to: :to_h

    attr_reader :title, :detail, :status, :source
  end
end