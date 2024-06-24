class ApplicationConfig < ApplicationRecord
    def self.get(search_key)
        self.where(key: search_key).first.value
    end
end
