module Burghers
  class Response
    attr_reader :topics, :tags, :entities, :raw

    def initialize(json)
      @raw = json

      @topics = []
      @tags = []
      @entities = []
      @relations = []

      if @raw['doc']['meta']['language'] == "InputTextTooShort"
        raise DocumentTooSmallError, "Document too short to process."
      end

      @raw.each do |key, value|
        case value["_typeGroup"]
          when 'topics'
            @topics << { name: value['categoryName'], score: value['score'].to_f }
          when 'socialTag'
            @tags << { name: value['name'], :score => value['importance'].to_f }
          when 'entities'
            @entities << value
          when 'relations'
            @relations << value
        end
      end
    end
  end
end
