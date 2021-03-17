class Image < ApplicationRecord
  validates :link, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp }
end
