module Burghers
  class DocumentTooSmallError < RuntimeError
  end

  class UnsupportedLanguageError < RuntimeError
  end

  class CalaisResponseError < RuntimeError
  end
end
