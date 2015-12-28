# coding: utf-8
class Reply < ActiveRecord::Base
  belongs_to :ticket, dependent: :destroy
  belongs_to :user
end
