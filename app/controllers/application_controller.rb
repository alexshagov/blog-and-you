class ApplicationController < ActionController::Base
  include Clearance::Controller
  prepend_view_path Rails.root.join('frontend')
end
