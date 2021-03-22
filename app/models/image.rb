class Image < ApplicationRecord
  validates :link, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp }

  acts_as_taggable_on :tags
end
