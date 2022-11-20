# frozen_string_literal: true

folders = %w[authors comments videos]
folders.each do |folder|
  require_relative "#{folder}/init"
end
