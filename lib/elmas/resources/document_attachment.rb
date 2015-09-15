module Elmas
  class DocumentAttachment
    include Elmas::Resource

    def valid_actions
      [:get]
    end

    def base_path
      "documents/DocumentAttachments"
    end

    def mandatory_attributes
      [:attachment, :document, :file_name]
    end

    def other_attributes
      []
    end
  end
end
