module ApplicationHelper

  # change the default link renderer for will_paginate
  def will_paginate(collection_or_options = nil, options = {})
    if collection_or_options.is_a? Hash
      options, collection_or_options = collection_or_options, nil
    end
    unless options[:renderer]
      options = options.merge :renderer => FoundationPagination::Rails
    end
    super *[collection_or_options, options].compact
  end

  def days_ago(date)
    days = ((Time.now - date) / 24 / 60 / 60).round

    case days
      when 0    then time_ago_in_words(date)
      when 1    then 'yesterday'
      else           "#{days}d"
    end
  end


end
