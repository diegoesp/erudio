module ApplicationHelper

  class String
    def is_number?
      true if Float(self) rescue false
    end

    def is_boolean?
      true if self == "true"
      true if self == "false"
      false
    end
  end

end
